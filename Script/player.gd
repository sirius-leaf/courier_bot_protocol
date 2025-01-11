extends CharacterBody2D
class_name Player

@export var moveDistance: float = 16.0
@export var moveSpeed: float = 0.2

var _playerPos := Vector2(0.0, 0.0)
var _onMovingPlatform := false
var _playerPosOnMoving := 0.0
var _onMovingPlatformOffsetX := 0.0
var _movingPlatform: MovingObject
var _onPlatformOffsetX: float
var _onWater := false

@onready var check_up: RayCast2D = $MovementCheckRaycast/CheckUp
@onready var check_down: RayCast2D = $MovementCheckRaycast/CheckDown
@onready var check_left: RayCast2D = $MovementCheckRaycast/CheckLeft
@onready var check_right: RayCast2D = $MovementCheckRaycast/CheckRight

func _ready() -> void:
	print(OS.has_feature("web_android") or OS.has_feature("web_ios"))

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_up") and not check_up.is_colliding():
		_playerPos.y -= moveDistance
	elif Input.is_action_just_pressed("ui_down") and not check_down.is_colliding():
		_playerPos.y += moveDistance
	elif Input.is_action_just_pressed("ui_left") and not check_left.is_colliding():
		if not _onMovingPlatform:
			_playerPos.x -= moveDistance
		else:
			_playerPosOnMoving -= moveDistance
	elif Input.is_action_just_pressed("ui_right") and not check_right.is_colliding():
		if not _onMovingPlatform:
			_playerPos.x += moveDistance
		else:
			_playerPosOnMoving += moveDistance
	
	if _onWater and not _onMovingPlatform: get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	global_position.y = lerp(global_position.y, _playerPos.y, moveSpeed)
	
	if not _onMovingPlatform:
		global_position.x = lerp(global_position.x, _playerPos.x, moveSpeed)
	else:
		_onMovingPlatformOffsetX = lerp(_onMovingPlatformOffsetX, _playerPosOnMoving, moveSpeed)
		global_position.x = _movingPlatform.global_position.x + _onPlatformOffsetX + _onMovingPlatformOffsetX
		_playerPos.x = roundf(global_position.x / 16.0) * 16.0


func _input(event: InputEvent) -> void:
	if event.is_action_released("reset_scene"):
		get_tree().reload_current_scene()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		_movingPlatform = area
		_onMovingPlatform = true
		_onPlatformOffsetX = global_position.x - area.global_position.x


func _on_area_2d_area_exited(area: Area2D) -> void:
	if area.is_in_group("Platform"):
		_onMovingPlatformOffsetX = 0.0
		_playerPosOnMoving = 0.0
		_onMovingPlatform = false


func _on_water_check_area_entered(area: Area2D) -> void:
	_onWater = true


func _on_water_check_area_exited(area: Area2D) -> void:
	_onWater = false
