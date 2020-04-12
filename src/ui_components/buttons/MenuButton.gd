extends Button

export(String) var scene_path: String

func _on_MenuButton_pressed():
	get_tree().paused = false
	get_tree().change_scene(scene_path)
