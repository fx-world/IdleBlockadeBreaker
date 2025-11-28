extends Node2D

@export
var speed : float = 15

@export
var maxScrool : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	maxScrool = $Camera2D.offset.y
	$Camera2D.offset.y = -480


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Camera2D.offset.y += delta * speed
	
	if $Camera2D.offset.y > maxScrool:
		SceneTransition.change_scene("res://scenes/menu/main_menu.tscn")
	
