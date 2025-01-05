extends Node2D

@export var carScene: PackedScene
@export var spawnTime := [2.0, 6.0]
@export var moveSpeed := [30.0, 50.0]
@export_range(-1, 1, 1) var overrideMoveDirection := 0
@export var isWater := false

var _carMoveSpeed: float
var _moveDirection: int

@onready var spawn_delay: Timer = $SpawnDelay
@onready var water: Area2D = $Water

func _ready() -> void:
	if isWater: water.monitorable = true
	_set_delay()
	
	_carMoveSpeed = randf_range(moveSpeed[0], moveSpeed[1])
	_moveDirection = 1 - randi_range(0, 1) * 2 if overrideMoveDirection == 0 else overrideMoveDirection
	
	var spawnPos := 0.0
	
	while (_moveDirection > 0 and spawnPos < 460) or (_moveDirection < 0 and spawnPos > -460):
		var car: MovingObject = carScene.instantiate()
		car.moveSpeed = _carMoveSpeed * _moveDirection
		car.global_position = Vector2(-230.0 * _moveDirection + spawnPos, global_position.y)
		car.global_rotation_degrees = 180.0 if _moveDirection < 0 else 0.0
		$"..".add_child.call_deferred(car)
		
		spawnPos += _carMoveSpeed * randf_range(spawnTime[0], spawnTime[1]) * _moveDirection


func _on_spawn_delay_timeout() -> void:
	var car: MovingObject = carScene.instantiate()
	car.moveSpeed = _carMoveSpeed * _moveDirection
	car.global_position = Vector2(-230.0 * _moveDirection, global_position.y)
	car.global_rotation_degrees = 180.0 if _moveDirection < 0 else 0.0
	$"..".add_child(car)
	
	_set_delay()


func _set_delay() -> void:
	spawn_delay.wait_time = randf_range(spawnTime[0], spawnTime[1])
	spawn_delay.start()
