extends Control

export var is_playing_quest: = false

func _input(event):
	if event.is_action_pressed("pause") and not get_owner().is_game_over():
		if is_playing_quest:
			get_owner().find_node("Quest").end()
		else:
			change_pause_state(not get_tree().paused)

func change_pause_state(state: bool):
	get_tree().paused = state
	visible = state


func _on_ContinueButton_pressed():
	change_pause_state(false)
