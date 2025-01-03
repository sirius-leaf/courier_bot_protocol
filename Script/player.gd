extends CharacterBody2D
class_name Player

@export var moveDistance: float = 16.0
@export var moveSpeed: float = 0.2

var _playerPos := Vector2(0.0, 0.0)

@onready var check_up: RayCast2D = $CheckUp
@onready var check_down: RayCast2D = $CheckDown
@onready var check_left: RayCast2D = $CheckLeft
@onready var check_right: RayCast2D = $CheckRight

func _process(delta: float) -> void:
	var is_moving: bool = true if global_position.distance_to(_playerPos) > 5.0 else false
	
	if not is_moving:
		if not check_up.is_colliding() and Input.is_action_just_pressed("ui_up"):
			_playerPos.y -= moveDistance
		elif not check_down.is_colliding() and Input.is_action_just_pressed("ui_down"):
			_playerPos.y += moveDistance
		elif not check_left.is_colliding() and Input.is_action_just_pressed("ui_left"):
			_playerPos.x -= moveDistance
		elif not check_right.is_colliding() and Input.is_action_just_pressed("ui_right"):
			_playerPos.x += moveDistance


func _physics_process(delta: float) -> void:
	global_position = lerp(global_position, _playerPos, moveSpeed)


func _input(event: InputEvent) -> void:
	if event.is_action_released("reset_scene"):
		get_tree().reload_current_scene()
