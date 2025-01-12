extends CharacterBody2D
class_name Player

const MOVING_THRESHOLD := 6.0

@export var moveDistance := 16.0
@export var moveSpeed := 0.15
@export var smallPlayer := true

var _playerPos := Vector2(0.0, 0.0)
var _onMovingPlatform := false
var _playerPosOnMoving := 0.0
var _onMovingPlatformOffsetX := 0.0
var _movingPlatform: MovingObject
var _onPlatformOffsetX: float
var _onWater := false
var _isMoving := true
var _movingOnPlatform := false
var _moveAngle := 270.0

@onready var check_up: Area2D = $MovementCheckRaycast/CheckUp
@onready var check_down: Area2D = $MovementCheckRaycast/CheckDown
@onready var check_left: RayCast2D = $MovementCheckRaycast/CheckLeft
@onready var check_right: RayCast2D = $MovementCheckRaycast/CheckRight
@onready var sprite: Sprite2D = $Sprite

func _process(delta: float) -> void:
	_isMoving = true if (
		abs(global_position.y - _playerPos.y) > MOVING_THRESHOLD or
		(not _onMovingPlatform and abs(global_position.x - _playerPos.x) > MOVING_THRESHOLD) or
		(_onMovingPlatform and _movingOnPlatform)
	) else false
	
	const MOVE_SCALE_CHANGE := 0.8
	const MOVE_ROTATION_AMOUNT := 7.5
	
	if not _isMoving:
		if Input.is_action_just_pressed("ui_up") and not check_up.has_overlapping_bodies():
			_playerPos.y -= moveDistance
			
			if smallPlayer:
				sprite.scale.y = MOVE_SCALE_CHANGE
				_moveAngle = 270.0
			else:
				sprite.scale.x = 0.9
		elif Input.is_action_just_pressed("ui_down") and not check_down.has_overlapping_bodies():
			_playerPos.y += moveDistance
			
			if smallPlayer:
				sprite.scale.y = MOVE_SCALE_CHANGE
				_moveAngle = 90.0
			else:
				sprite.scale.x = 0.9
		elif Input.is_action_just_pressed("ui_left") and not check_left.is_colliding():
			if not _onMovingPlatform:
				_playerPos.x -= moveDistance
			else:
				_playerPosOnMoving -= moveDistance
			
			if smallPlayer:
				_moveAngle = 180.0
				sprite.scale.y = MOVE_SCALE_CHANGE
			else:
				sprite.rotation_degrees = -MOVE_ROTATION_AMOUNT
		elif Input.is_action_just_pressed("ui_right") and not check_right.is_colliding():
			if not _onMovingPlatform:
				_playerPos.x += moveDistance
			else:
				_playerPosOnMoving += moveDistance
			
			if smallPlayer:
				_moveAngle = 0.0
				sprite.scale.y = MOVE_SCALE_CHANGE
			else:
				sprite.rotation_degrees = MOVE_ROTATION_AMOUNT
	
	if _onWater and not _onMovingPlatform: get_tree().reload_current_scene()


func _physics_process(delta: float) -> void:
	global_position.y = lerp(global_position.y, _playerPos.y, moveSpeed)
	sprite.rotation = lerp_angle(sprite.rotation, deg_to_rad(_moveAngle), 0.3) if smallPlayer else lerp_angle(sprite.rotation, 0.0, 0.1)
	sprite.scale = lerp(sprite.scale, Vector2(1.0, 1.0), 0.1)
	
	if not _onMovingPlatform:
		global_position.x = lerp(global_position.x, _playerPos.x, moveSpeed)
	else:
		_onMovingPlatformOffsetX = lerp(_onMovingPlatformOffsetX, _playerPosOnMoving, moveSpeed)
		_movingOnPlatform = true if abs(_onMovingPlatformOffsetX - _playerPosOnMoving) > MOVING_THRESHOLD else false
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
