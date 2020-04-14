extends Control

func _input(event):
	if event.is_action_pressed("pause") and not get_owner().is_game_over():
		change_pause_state(not get_tree().paused)

func change_pause_state(state: bool):
	get_tree().paused = state
	visible = state


func _on_ContinueButton_pressed():
	change_pause_state(false)
