extends Camera2D

@export
var shakeBaseAmount := 1.0
@export
var shakeDampening := 0.075

var shakeAmount := 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shakeAmount > 0:
		position.x = randf_range(-shakeBaseAmount, shakeAmount) * shakeAmount
		position.y = randf_range(-shakeBaseAmount, shakeAmount) * shakeAmount
		shakeAmount = lerpf(shakeAmount, 0.0, shakeDampening)
	else:
		position = Vector2(0, 0)

func shake(value: float) -> void:
	shakeAmount += value
