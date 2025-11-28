extends Area2D
class_name Bullet

var plBulletEffect := preload("res://scenes/enemies/bullet_effect.tscn")

@export
var playerBullet : bool = false

@export
var sound: AudioStream

@export
var speed: float = 100

@export
var damage: int = 5

var vel: Vector2 = Vector2(0, 0)
var dir: Vector2 = Vector2(1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("default")
	AudioManager.playEffect(position, sound)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	vel = dir.normalized() * speed
	position += vel * delta
	look_at(position + dir)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("damageable"):
		if playerBullet and area is BaseEnemy:
			var bulletEffect := plBulletEffect.instantiate()
			bulletEffect.position = position
			get_parent().add_child(bulletEffect)
			
			area.damage(damage)			
			queue_free()
		elif not playerBullet and area is MainShip:
			var bulletEffect := plBulletEffect.instantiate()
			bulletEffect.position = position
			get_parent().add_child(bulletEffect)
			
			area.damage(damage)			
			queue_free()
	

func _on_visible_exited() -> void:
	queue_free()
