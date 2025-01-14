extends Node2D
class_name Finish

signal playerEntered

var _closeGate := [false, false, false, false, false]

@onready var finish_1: Area2D = $Finish1
@onready var finish_2: Area2D = $Finish2
@onready var finish_3: Area2D = $Finish3
@onready var finish_4: Area2D = $Finish4
@onready var finish_5: Area2D = $Finish5
@onready var gate_1_satic_body: StaticBody2D = $Gate1/Gate1SaticBody
@onready var gate_2_satic_body: StaticBody2D = $Gate2/Gate2SaticBody
@onready var gate_3_satic_body: StaticBody2D = $Gate3/Gate3SaticBody
@onready var gate_4_satic_body: StaticBody2D = $Gate4/Gate4SaticBody
@onready var gate_5_satic_body: StaticBody2D = $Gate5/Gate5SaticBody
@onready var gate_1: Node2D = $Gate1
@onready var gate_2: Node2D = $Gate2
@onready var gate_3: Node2D = $Gate3
@onready var gate_4: Node2D = $Gate4
@onready var gate_5: Node2D = $Gate5
@onready var finish_light_1: Sprite2D = $FinishLight1
@onready var finish_light_2: Sprite2D = $FinishLight2
@onready var finish_light_3: Sprite2D = $FinishLight3
@onready var finish_light_4: Sprite2D = $FinishLight4
@onready var finish_light_5: Sprite2D = $FinishLight5

func _process(delta: float) -> void:
	if _closeGate[0]:
		var gatePosX: float = gate_1.get_node("GateLeft").position.x
		if gatePosX < -12.01:
			gate_1.get_node("GateLeft").position.x = lerp(gatePosX, -12.0, 0.12)
			gate_1.get_node("GateRight").position.x = -gatePosX
		else:
			gate_1.get_node("GateLeft").position.x = -12.0
			gate_1.get_node("GateRight").position.x = 12.0
			_closeGate[0] = false
	elif _closeGate[1]:
		var gatePosX: float = gate_2.get_node("GateLeft").position.x
		if gatePosX < -12.01:
			gate_2.get_node("GateLeft").position.x = lerp(gatePosX, -12.0, 0.12)
			gate_2.get_node("GateRight").position.x = -gatePosX
		else:
			gate_2.get_node("GateLeft").position.x = -12.0
			gate_2.get_node("GateRight").position.x = 12.0
			_closeGate[1] = false
	elif _closeGate[2]:
		var gatePosX: float = gate_3.get_node("GateLeft").position.x
		if gatePosX < -12.01:
			gate_3.get_node("GateLeft").position.x = lerp(gatePosX, -12.0, 0.12)
			gate_3.get_node("GateRight").position.x = -gatePosX
		else:
			gate_3.get_node("GateLeft").position.x = -12.0
			gate_3.get_node("GateRight").position.x = 12.0
			_closeGate[2] = false
	elif _closeGate[3]:
		var gatePosX: float = gate_4.get_node("GateLeft").position.x
		if gatePosX < -12.01:
			gate_4.get_node("GateLeft").position.x = lerp(gatePosX, -12.0, 0.12)
			gate_4.get_node("GateRight").position.x = -gatePosX
		else:
			gate_4.get_node("GateLeft").position.x = -12.0
			gate_4.get_node("GateRight").position.x = 12.0
			_closeGate[3] = false
	elif _closeGate[4]:
		var gatePosX: float = gate_5.get_node("GateLeft").position.x
		if gatePosX < -12.01:
			gate_5.get_node("GateLeft").position.x = lerp(gatePosX, -12.0, 0.12)
			gate_5.get_node("GateRight").position.x = -gatePosX
		else:
			gate_5.get_node("GateLeft").position.x = -12.0
			gate_5.get_node("GateRight").position.x = 12.0
			_closeGate[4] = false


func _on_finish_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_1.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
		gate_1_satic_body.set_process_mode(Node.PROCESS_MODE_INHERIT)
		finish_light_1.modulate = Color.hex(0xff1d1dff)
		_closeGate[0] = true


func _on_finish_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_2.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
		gate_2_satic_body.set_process_mode(Node.PROCESS_MODE_INHERIT)
		finish_light_2.modulate = Color.hex(0xff1d1dff)
		_closeGate[1] = true


func _on_finish_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_3.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
		gate_3_satic_body.set_process_mode(Node.PROCESS_MODE_INHERIT)
		finish_light_3.modulate = Color.hex(0xff1d1dff)
		_closeGate[2] = true


func _on_finish_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_4.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
		gate_4_satic_body.set_process_mode(Node.PROCESS_MODE_INHERIT)
		finish_light_4.modulate = Color.hex(0xff1d1dff)
		_closeGate[3] = true


func _on_finish_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_5.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
		gate_5_satic_body.set_process_mode(Node.PROCESS_MODE_INHERIT)
		finish_light_5.modulate = Color.hex(0xff1d1dff)
		_closeGate[4] = true


func _on_spike_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"): get_tree().reload_current_scene.call_deferred()
