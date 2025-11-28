extends Node

var timePlayed : int
var skills = {}
var knowledge : int
var material : int

func _ready() -> void:
	reset()

func reset() -> void:
	skills = {}
	timePlayed = 0
	knowledge = 1
	material = 1

func setSkill(name: String, level: int) -> void:
	#var l = skills.get_or_add(name, 0)
	skills[name] = level

func getSkill(name: String)	-> int:
	return skills.get(name, 0)

func gets(knowledgeCost : int, materialCost: int) -> void:
	knowledge += knowledgeCost
	material += materialCost
	Signals.emit_signal("on_knowledge_or_material_changed", knowledge, material)

func owns(knowledgeCost : int, materialCost: int) -> bool:
	return knowledge >= knowledgeCost and material >= materialCost

func buy(knowledgeCost : int, materialCost: int) -> bool:
	if owns(knowledgeCost, materialCost):
		knowledge -= knowledgeCost
		material -= materialCost
		Signals.emit_signal("on_knowledge_or_material_changed", knowledge, material)
		return true
	else:
		return false
