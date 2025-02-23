extends CanvasLayer

@onready var mobile_ui: Control = $MobileUI

func _ready() -> void:
	if not (OS.has_feature("web_android") or OS.has_feature("web_ios")):
		mobile_ui.process_mode = Node.PROCESS_MODE_DISABLED
		mobile_ui.visible = false
