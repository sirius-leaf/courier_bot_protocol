extends Camera2D

@onready var sd_570: Player = $"../SD-570"

func _process(delta: float) -> void:
	if sd_570.global_position.y < 0.0:
		global_position.y = sd_570.global_position.y
