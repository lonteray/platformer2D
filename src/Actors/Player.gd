extends Actor

class_name Player

var cloud = null
var ui_component = null
var is_alive: = true

func _ready():
	health.init(Constants.PLAYER_HEALTH_NUM, Constants.PLAYER_HEALTH_DENOM)
	bind_scene_objects()
	update_health_label()
	ui_component.update_label(health.num, health.denom)
	lifetime_coroutine()
	$Sprite.play("Idle")

func bind_scene_objects() -> void:
	ui_component = get_tree().get_current_scene().find_node("DisplayCanvas")
	cloud = get_tree().get_current_scene().find_node("fight_cloud")

func _physics_process(delta: float) -> void:
	check_on_enemy()
	check_input_on_movement()

func check_input_on_movement() -> void:
	if Input.is_action_pressed("move_left"):
		var intensity: = Input.get_action_strength("move_left")
		move_left(intensity)
	elif Input.is_action_pressed("move_right"):
		var intensity: = Input.get_action_strength("move_right")
		move_right(intensity)
	else:
		velocity.x = 0
	if Input.is_action_pressed("jump") and is_on_floor():
		var jump_strength: = Input.get_action_strength("jump")
		jump(jump_strength)
	if not is_on_floor():
		$Sprite.play("Jump")
	else:
		$Sprite.play("Idle")

func jump(strength: float) -> void:
	velocity.y = -speed.y * strength
	
func check_on_enemy() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.collision_layer == Constants.ENEMY_LEVEL:
			fight(collision.collider)
			break

func fight(enemy: Enemy) -> void:
	print("Fight!")
	fight_coroutine(enemy)

# override
func will_die() -> void:
	print("Player should die")
	get_node("CollisionShape2D").disabled = true
	ui_component.update_status(0.0)
	ui_component.game_over()
	is_alive = false

func fight_coroutine(enemy: Enemy) -> void:
	set_active(false)
	cloud.set_active(true, position, enemy.position)
	enemy.set_active(false)
	#yield(get_tree().create_timer(1.0), "timeout")
	var timer = Timer.new()
	timer.set_wait_time(Constants.FIGHT_TIME)
	timer.set_one_shot(true)
	self.add_child(timer)
	timer.start()
	yield(timer, "timeout")
	timer.queue_free()
	if !enemy:
		print("Enemy is empty")
	var result: = health.compare(enemy.health)
	if result >= 0:
		end_of_fight(self, enemy)
		ui_component.update_label(health.num, health.denom)
	else:
		end_of_fight(enemy, self)
		ui_component.update_label(0, 1)
	cloud.set_active(false)

func end_of_fight(winner: Actor, looser: Actor) -> void:
	winner.health.add(looser.health)
	winner.update_health_label()
	looser.will_die()
	winner.set_active(true)

func lifetime_coroutine() -> void:
	var timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(Constants.PLAYER_HEALTH_INNER_STEP)
	self.add_child(timer)
	while true:
		var outer: = calc_health_reduce_level()
		var inner: = 0.0
		var progress: = 0.0
		var last_denom: = health.denom
		var was_fight: = false
		while inner < outer:
			#yield(get_tree().create_timer(Constants.PLAYER_HEALTH_INNER_STEP), "timeout")
			timer.start()
			yield(timer, "timeout")
			if !is_alive:  
				die()
				return
			if is_physics_processing():
				if was_fight:
					if last_denom != health.denom:
						outer = calc_health_reduce_level()
						inner = 0.0
						last_denom = health.denom
					was_fight = false
				else:
					progress = float(outer - inner) / outer
					ui_component.update_status(progress)
					inner += Constants.PLAYER_HEALTH_INNER_STEP
			else:
				was_fight = true
		#health.num -= 1
		ui_component.update_label(health.num, health.denom)
		if health.num <= 0:
			will_die()
			die()
			return
		update_health_label()
	timer.queue_free()

func calc_health_reduce_level() -> float:
	return Constants.PLAYER_LIFETIME / health.denom
