extends Camera2D

var _currentPlayer := 0
var _player: Player

@onready var player_1: Player = $"../Players/Player1"
@onready var player_2: Player = $"../Players/Player2"
@onready var player_3: Player = $"../Players/Player3"
@onready var player_4: Player = $"../Players/Player4"
@onready var player_5: Player = $"../Players/Player5"
@onready var finish: Finish = $"../Finish"

func _ready() -> void:
	finish.playerEntered.connect(_on_finish_player_entered.bind())


func _process(delta: float) -> void:
	match _currentPlayer:
		0:
			global_position.y = player_1.global_position.y if player_1.global_position.y <= 0.0 else 0.0
		1:
			global_position.y = player_2.global_position.y if player_2.global_position.y <= 0.0 else 0.0
		2:
			global_position.y = player_3.global_position.y if player_3.global_position.y <= 0.0 else 0.0
		3:
			global_position.y = player_4.global_position.y if player_4.global_position.y <= 0.0 else 0.0
		4:
			global_position.y = player_5.global_position.y if player_5.global_position.y <= 0.0 else 0.0


func _on_finish_player_entered():
	_currentPlayer += 1
	
	match _currentPlayer:
		1:
			player_1.process_mode = Node.PROCESS_MODE_DISABLED
			player_2.process_mode = Node.PROCESS_MODE_INHERIT
		2:
			player_2.process_mode = Node.PROCESS_MODE_DISABLED
			player_3.process_mode = Node.PROCESS_MODE_INHERIT
		3:
			player_3.process_mode = Node.PROCESS_MODE_DISABLED
			player_4.process_mode = Node.PROCESS_MODE_INHERIT
		4:
			player_4.process_mode = Node.PROCESS_MODE_DISABLED
			player_5.process_mode = Node.PROCESS_MODE_INHERIT
		5:
			player_5.process_mode = Node.PROCESS_MODE_DISABLED
