extends Area2D
class_name BaseEnemy

var plBullet : Resource = preload("res://scenes/enemies/bullet.tscn")

@export
var speed: float = 100
var vel : Vector2 = Vector2(0, 0)
var dir : Vector2 = Vector2(-1 ,0)
@export
var shootInterval: float = 2
var timeToNextShoot: float = 0
@export
var shootDir :Vector2 = Vector2(-1, 0)
@export
var life: int = 10
@export
var knowledgeOnKill : int = 1
@export
var materialOnKill : int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timeToNextShoot = shootInterval;
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Shooting
	timeToNextShoot -= delta
	if timeToNextShoot < 0:
		for shootingPosition in $ShootingPositions.get_children():
			var bullet : Bullet = plBullet.instantiate()
			bullet.position = position + shootingPosition.position
			bullet.dir = shootDir
			get_tree().current_scene.add_child(bullet)
			timeToNextShoot = shootInterval
	
func _physics_process(delta: float) -> void:
	vel = dir.normalized() * speed
	position += vel * delta
	
	# Make sure that we are within the screen
	var viewRect := get_viewport_rect()
	
	if viewRect.size.y < position.y and dir.y > 0:
		dir.y *= -1
	elif  position.y < 0 and dir.y < 0:
		dir.y *= -1
		
	position.y = clamp(position.y, 0, viewRect.size.y)
	
	if position.x < -100:
		queue_free()

func damage(amount: int):
	life -= amount
	if life <= 0:
		GameState.gets(knowledgeOnKill, materialOnKill)
		queue_free()

func _on_visible_exited() -> void:
	if position.x < 0:
		queue_free()
