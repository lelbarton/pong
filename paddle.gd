extends Area2D

var screen_size

enum Side {Left, Right}

@export var side: Side
@export var up_key: String
@export var down_key: String

var x_pos_lock
var paddle_size
var speed = 400

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	paddle_size = $CollisionShape2D.shape.size
	var paddle_half_width = paddle_size.x / 2
	
	if (side == Side.Left):
		x_pos_lock = paddle_half_width
		$Sprite2D.flip_v = true
		$Sprite2D.flip_h = false
	else:
		x_pos_lock = screen_size.x - paddle_half_width
		$Sprite2D.flip_v = false
		$Sprite2D.flip_h = true
		
func clamp_paddle() -> void:
	position = position.clamp(Vector2(x_pos_lock, paddle_size.y / 2), Vector2(x_pos_lock, screen_size.y - paddle_size.y / 2))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed(up_key):
		velocity.y = -1
	if Input.is_action_pressed(down_key):
		velocity.y = 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	clamp_paddle()
	
func start(y_pos):
	position = Vector2(x_pos_lock, y_pos)
	show()
	$CollisionShape2D.disabled = false
