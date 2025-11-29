extends Node

@onready
var lifeBar : TextureProgressBar = $HUD/LifeBar

@onready
var camera : Camera2D = $Camera

@export
var shipSpeed: float = 1.0

@export
var background_star_velocity_min: float = 70.0
@export
var background_star_velocity_max: float = 70.0

@export
var timeToKnowledge: float = 5
var timeToKnowledgeCollected: float = 0
@export
var knowledgePerTime: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Background/MovingStars.initial_velocity_min = background_star_velocity_min * shipSpeed;
	$Background/MovingStars.initial_velocity_max = background_star_velocity_max * shipSpeed;
	
	Signals.connect("on_mainship_life_changed", on_mainship_life_changed)

func _process(delta: float) -> void:
	timeToKnowledgeCollected += delta
	if timeToKnowledgeCollected >= timeToKnowledge:
		timeToKnowledgeCollected = 0
		GameState.gets(knowledgePerTime, 0)

func _physics_process(delta: float) -> void:
	var win = true
	for child in get_children():
		if child is BaseEnemy or child is EnemySpawner:
			win = false
			break
	if win == true:
		SceneTransition.change_scene("res://scenes/menu/credits.tscn")

func on_mainship_life_changed(life: int, maxLife: int):
	if life < lifeBar.value:
		camera.shake(lifeBar.value - life)
	lifeBar.max_value = maxLife
	lifeBar.value = life	
	
	if life <= 0:
		SceneTransition.change_scene("res://scenes/skills/skill_tree.tscn")

func _on_retreat_pressed() -> void:
	SceneTransition.change_scene("res://scenes/skills/skill_tree.tscn")
