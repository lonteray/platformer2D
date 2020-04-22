extends Actor

class_name Enemy

var is_right_direction: = true

func _ready():
	health.init(Constants.ENEMY_HEALTH_NUM, Constants.ENEMY_HEALTH_DENOM)
	update_health_label()
	$Sprite.flip_h = true
	speed.x *= Constants.ENEMY_SPEED_SLOWER

func will_die():
	$CollisionShape2D.disabled = true
	visible = false
	$Sprite.stop()
	set_physics_process(false)

func reborn(position: Vector2):
	$CollisionShape2D.disabled = false
	visible = true
	$Sprite.play()
	set_physics_process(true)
	set_position(position)

func _physics_process(delta: float) -> void:
	if is_on_floor():
		check_direction()
		if is_right_direction:
			move_right()
		else:
			move_left()
			
func check_direction() -> void:
	if is_on_wall():
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.collision_layer == Constants.PLAYER_LEVEL:
				print("Enemy met player")
				collision.collider.fight(self)
				return
		#switch direction
		if is_right_direction:
			$Sprite.flip_h = false
			is_right_direction = false
		else:
			$Sprite.flip_h = true
			is_right_direction = true
