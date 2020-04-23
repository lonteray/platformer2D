extends PlayerTool

class_name Camp

export var adding_health: = 0.0

func _on_Camp_body_entered(body: KinematicBody2D):
	if is_active:
		switch_message(true)
	is_player_here = true

func _on_Camp_body_exited(body: KinematicBody2D):
	if is_active:
		switch_message(false)
	is_player_here = false

func _process(delta):
	if is_active and is_player_here and Input.is_action_pressed("heal"):
		heal()

func heal() -> void:
	player.health.add_value(adding_health)
	player.update_health_label()
	set_active(false)
	refresh_coroutine()

func set_active(active: bool) -> void:
	is_active = active
	get_node("HealingSprite").visible = active
	if is_player_here:
		switch_message(active)

func refresh_coroutine() -> void:
	var timer = Timer.new()
	timer.set_wait_time(Constants.CAMP_HEALING_REFRESH_TIME)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	#yield(get_tree().create_timer(Constants.CAMP_HEALING_REFRESH_TIME), "timeout")
	set_active(true)
	timer.queue_free()
