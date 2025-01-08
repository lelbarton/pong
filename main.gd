extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func new_game() -> void:
	$PaddlePlayer1.start($Paddle1StartPos.position.y)
	$PaddlePlayer2.start($Paddle2StartPos.position.y)
