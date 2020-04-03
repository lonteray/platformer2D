extends Actor

class_name Player

export var init_num = 3
export var init_denom = 3

var cloud = null
var gl_health_label = null

func _ready():
	health.num = init_num
	health.denom = init_denom
	gl_health_label = get_tree().get_root().get_node("TestSpace").find_node("g_healthLabel")
	update_health_label()
	update_global_label()
	cloud = get_tree().get_root().get_node("TestSpace").find_node("fight_cloud")
	lifetime_coroutine()

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

func fight(enemy: Enemy) -> void:
	print("Fight!")
	fight_coroutine(enemy)
	print("Uno")

func fight_coroutine(enemy: Enemy) -> void:
	set_active(false)
	cloud.set_active(true, position, enemy.position)
	enemy.set_active(false)
	yield(get_tree().create_timer(1.0), "timeout")
	print("Dos")
	if !enemy:
		print("Enemy is empty")
	var result: = health.compare(enemy.health)
	if result >= 0:
		end_of_fight(self, enemy)
		update_global_label()
	else:
		end_of_fight(enemy, self)
	cloud.set_active(false)

func end_of_fight(winner: Actor, looser: Actor) -> void:
	winner.health.add(looser.health)
	winner.update_health_label()
	looser.die()
	winner.set_active(true)

func lifetime_coroutine() -> void:
	while true:
		var step = Constants.PLAYER_LIFETIME / health.denom
		yield(get_tree().create_timer(step), "timeout")
		if is_physics_processing():
			health.num -= 1
		update_global_label()
		if health.num <= 0:
			die()
			break
		update_health_label()

func update_global_label() -> void:
	var text = str(health.num) + '/' + str(health.denom)
	gl_health_label.text = text
