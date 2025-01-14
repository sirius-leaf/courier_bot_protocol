extends Area2D
class_name MovingObject

const CAR_COLOR_PRESETS := [
	0xffffffff, 0xff2929ff, 0xf3902eff,
	0x3ae23fff, 0x619d9dff, 0x1c3ed5ff,
	0xa95da4ff, 0x898989ff, 0x393939ff
]

@export var moveSpeed: float = 64.0
@export var isPlatform := false

func _ready() -> void:
	if not isPlatform:
		var car: Sprite2D = $Car
		var stripe: Sprite2D = $Car/Stripe
		
		car.self_modulate = Color.hex(CAR_COLOR_PRESETS.pick_random())
		if randi_range(0, 1) == 0: stripe.visible = true


func _physics_process(delta: float) -> void:
	position.x += moveSpeed * delta


func _on_body_entered(body: Node2D) -> void:
	if not isPlatform and body.is_in_group("Player"):
		get_tree().reload_current_scene.call_deferred()
