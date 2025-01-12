extends Camera2D

var _currentPlaye := 0
var _player: Player

@onready var player_1: Player = $"../Players/Player1"

func _process(delta: float) -> void:
	global_position.y = player_1.global_position.y if player_1.global_position.y <= 0.0 else 0.0
