extends Node2D
class_name Finish

signal playerEntered

@onready var finish_1: Area2D = $Finish1
@onready var finish_2: Area2D = $Finish2
@onready var finish_3: Area2D = $Finish3
@onready var finish_4: Area2D = $Finish4
@onready var finish_5: Area2D = $Finish5

func _on_finish_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_1.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)


func _on_finish_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_2.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)


func _on_finish_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_3.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)


func _on_finish_4_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_4.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)


func _on_finish_5_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		playerEntered.emit()
		finish_5.set_process_mode.call_deferred(Node.PROCESS_MODE_DISABLED)
