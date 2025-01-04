extends Area2D
class_name Car

@export var MoveSpeed: float = 64.0

func _physics_process(delta: float) -> void:
	position.x += MoveSpeed * delta
