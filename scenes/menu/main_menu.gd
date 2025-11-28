extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	GameState.reset()
	SceneTransition.change_scene("res://scenes/skills/skill_tree.tscn")


func _on_options_pressed() -> void:
	SceneTransition.change_scene("res://scenes/menu/options.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	SceneTransition.change_scene("res://scenes/menu/credits.tscn")
