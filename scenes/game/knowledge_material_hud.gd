extends Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Signals.connect("on_knowledge_or_material_changed", on_knowledge_or_material_changed)
	updateVisuals();

func on_knowledge_or_material_changed(knowledge: int, material: int):
	updateVisuals();

func updateVisuals():
	text = str(GameState.knowledge) + "K | " + str(GameState.material) + "M"
