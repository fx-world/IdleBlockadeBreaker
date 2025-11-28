extends Area2D
class_name EnemySpawner

@onready
var timer : Timer = $Timer

@export
var enemyPrefab : PackedScene

@export
var initDelay : float = 0

@export
var amount : int = 1
var amountCounter : int = 0

@export
var delay : float = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.start(initDelay)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	# spawn an enemy
	var enemy : BaseEnemy = enemyPrefab.instantiate()
	enemy.position = position
	get_parent().add_child(enemy)
	amountCounter += 1
	
	if amountCounter < amount:
		timer.start(delay)
	else:
		queue_free()
