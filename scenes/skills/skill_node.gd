extends Button
class_name SkillNode

@onready
var label: Label = $Label

@onready
var connector: Line2D = $Connector

@export
var skillName: String

@export
var description: String

@export
var maxLevel: int = 1

@export
var knowledgeCostPerLevel : int = 0

@export
var materialCostPerLevel : int = 0

var level: int = 0:
	set(value):
		level = min(value, maxLevel)
		updateVisuals()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (skillName.is_empty()):
		skillName = name
	level = GameState.getSkill(skillName)
	Signals.connect("on_knowledge_or_material_changed", on_knowledge_or_material_changed)
	updateVisuals()


func on_knowledge_or_material_changed(knowledge: int, material: int):
	updateVisuals();	

func updateVisuals() -> void:
	tooltip_text = description + "\n(" + str(knowledgeCostPerLevel) + "K, " + str(materialCostPerLevel) + "M)" 
	label.text = str(level) + "/" + str(maxLevel)	
	if canBuy():
		self_modulate = Color(0.0, 0.606, 0.0, 1.0)
	elif level == maxLevel:
		self_modulate = Color(0.102, 0.498, 0.674, 1.0)
	else:
		self_modulate = Color(0.851, 0.102, 0.0, 1.0)
	
	if get_parent() is SkillNode:
		var parentNode : SkillNode = get_parent()
		connector.clear_points()
		connector.add_point(size/2)
		connector.add_point(parentNode.global_position - global_position + parentNode.size/2)
		
		if parentNode.level == 0:
			visible = false
		else:
			visible = true
	
	for child in get_children():
		if child is SkillNode:
			child.updateVisuals()

func _on_pressed() -> void:
	buy()
	
func canBuy() -> bool:
	return GameState.owns(knowledgeCostPerLevel, materialCostPerLevel) and level < maxLevel

func buy() -> void:
	if canBuy() and GameState.buy(knowledgeCostPerLevel, materialCostPerLevel):
		level += 1
		GameState.setSkill(skillName, level)
