extends Area2D

@export
var minSpeed: float = 50
@export
var maxSpeed: float = 80
@export
var minRotationRate: float = -20
@export
var maxRotationRate: float = 20

@export
var life: int = 20

var speed: float = 0
var rotationRate: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var viewRect := get_viewport_rect()
	speed = randf_range(minSpeed, maxSpeed)	
	rotationRate = randf_range(minRotationRate, maxRotationRate)	
	position.x = viewRect.size.x + 10
	position.y = randf_range(0, viewRect.size.y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float):
	rotation_degrees += rotationRate * delta
	position.x -= speed * delta

func damage(amount: int):
	life -= amount
	if life <= 0:
		queue_free()
		

func _on_area_entered(area: Area2D) -> void:
	#if area.is_in_group("damageable"):	
	#	area.damage(10)
	if area is MainShip:
		area.damage(10)

func _on_visible_exited() -> void:
	queue_free()
