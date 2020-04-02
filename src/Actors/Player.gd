extends Actor

export var init_num = 3
export var init_denom = 3

var cloud = null

func _ready():
	health.num = init_num
	health.denom = init_denom
	update_health_label()
	cloud = get_tree().get_root().get_node("TestSpace").find_node("fight_cloud")

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

func jump(strength: float) -> void:
	velocity.y = -speed.y * strength
	
func check_on_enemy() -> void:
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.collision_layer == Constants.ENEMY_LEVEL:
			fight(collision.collider)
			break

func fight(enemy: KinematicBody2D) -> void:
	print("Fight!")
	fight_coroutine(enemy)
	print("Uno")

func fight_coroutine(enemy: KinematicBody2D) -> void:
	setActive(false)
	cloud.set_active(true, position, enemy.position)
	enemy.setActive(false)
	yield(get_tree().create_timer(1.0), "timeout")
	print("Dos")
	if !enemy:
		print("Enemy is empty")
	var result: = health.compare(enemy.health)
	if result >= 0:
		health.add(enemy.health)
		update_health_label()
		enemy.die()
		setActive(true)
	else:
		enemy.health.add(health)
		enemy.update_health_label()
		die()
		enemy.setActive(true)
	cloud.set_active(false)
