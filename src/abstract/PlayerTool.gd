extends Area2D

class_name PlayerTool

export var trigger_message: String

var message_box
var player: Actor
var is_player_here: = false

func _ready():
	bind_scene_objects()

func bind_scene_objects() -> void:
	message_box = get_tree().get_current_scene().find_node("MessageBox")
	player = get_tree().get_current_scene().find_node("Player")

func switch_message(active: bool) -> void:
	if active:
		message_box.get_node("Message").text = trigger_message
	message_box.visible = active

