extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		change_pause_state(not get_tree().paused)

func change_pause_state(state: bool):
	get_tree().paused = state
	visible = state
