extends CanvasLayer

@onready var mobile_ui: Control = $MobileUI

func _ready() -> void:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		mobile_ui.process_mode = Node.PROCESS_MODE_INHERIT
		mobile_ui.visible = true
	else:
		mobile_ui.process_mode = Node.PROCESS_MODE_DISABLED
		mobile_ui.visible = false
