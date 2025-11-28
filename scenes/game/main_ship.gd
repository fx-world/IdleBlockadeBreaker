extends Area2D
class_name MainShip

var plBullet := preload("res://scenes/enemies/bullet.tscn")

@onready
var sprite := $Sprite2D

@onready
var gun := $FiringPositions/Gun

var maxLife: int = 25
var life: int = 100

var movementStyle = 0
var shootingStyle = 0

var speed: float = 100
var vel := Vector2(0, 0)
var dir := Vector2(0, 0)

@export
var shootInterval: float = 2
var timeToNextShoot: float = 0
var bulletDamage: float = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewRect := get_viewport_rect()
	
	# add skills
	if GameState.getSkill("ai1") > 0:
		movementStyle = 1
		dir = Vector2(0,1)
	
	if GameState.getSkill("weapons1") > 0:
		shootingStyle = 1
	
	shootInterval = shootInterval / (GameState.getSkill("firerate1") + 1)
	bulletDamage = bulletDamage * (GameState.getSkill("firepower1") + 1)
	maxLife = maxLife + (GameState.getSkill("armor1") * 50)
		
	timeToNextShoot = shootInterval;
	life = maxLife
	
	position.y = viewRect.size.y / 2
	
	Signals.emit_signal("on_mainship_life_changed", life, maxLife)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	# Shooting
	timeToNextShoot -= delta
	if shootingStyle > 0 and timeToNextShoot < 0:
		var bullet : Bullet = plBullet.instantiate()
		bullet.playerBullet = true
		bullet.position = position + gun.position
		bullet.damage = bulletDamage
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

func damage(amount: int):
	life -= amount
	Signals.emit_signal("on_mainship_life_changed", life, maxLife)
		
	if life <= 0:
		queue_free()
		
