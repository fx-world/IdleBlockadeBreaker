extends BaseEnemy

@export
var stopPositionX : float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	super(delta)
	if position.x < stopPositionX:
		dir = Vector2(0,0)
		position.x = stopPositionX
	#shootDir = 
