extends Area2D
class_name MovingObject

@export var moveSpeed: float = 64.0
@export var isPlatform := false

func _physics_process(delta: float) -> void:
	position.x += moveSpeed * delta


func _on_body_entered(body: Node2D) -> void:
	if not isPlatform and body.is_in_group("Player"):
		get_tree().reload_current_scene.call_deferred()
