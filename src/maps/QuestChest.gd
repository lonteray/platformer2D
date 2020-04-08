extends PlayerTool

class_name QuestChest

func _on_QuestChest_body_entered(body: KinematicBody2D):
	if is_active:
		switch_message(true)
	is_player_here = true

func _on_QuestChest_body_exited(body: KinematicBody2D):
	if is_active:
		switch_message(false)
	is_player_here = false

func set_active(active: bool) -> void:
	is_active = active
	visible = active
	if is_player_here:
		switch_message(active)

func _process(delta):
	if is_active and is_player_here and Input.is_action_pressed("play_quest"):
		start_quest()

func start_quest() -> void:
	print("Quest was started")
	set_active(false)
	refresh_coroutine()

func refresh_coroutine() -> void:
	yield(get_tree().create_timer(Constants.QUEST_CHEST_REFRESH_TIME), "timeout")
	set_active(true)
