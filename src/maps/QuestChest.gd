extends PlayerTool

class_name QuestChest
var quest
var pause_menu
export var treasure = 1.5

func _ready():
	quest = get_tree().get_current_scene().find_node("Quest")
	pause_menu = get_tree().get_current_scene().find_node("Pause")

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
	quest.visible = true
	quest.activate()
	pause_menu.is_playing_quest = true
	player.playing_quest = true

func exit_quest(finished: bool = false):
	quest.visible = false
	quest.reload()
	quest.disactivate()
	refresh_coroutine()
	pause_menu.is_playing_quest = false
	player.playing_quest = false
	if finished:
		player.health.add_value(treasure)
		player.update_health_label()

func refresh_coroutine() -> void:
	var timer = Timer.new()
	timer.set_wait_time(Constants.QUEST_CHEST_REFRESH_TIME)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	#yield(get_tree().create_timer(Constants.QUEST_CHEST_REFRESH_TIME), "timeout")
	set_active(true)
