extends Area2D

class_name LocationArea

#export var enemies_count: = 0
#export var left_enemy_position: Vector2
#export var right_enemy_position: Vector2
export var enemies_positions: PoolVector2Array
export var enemy_path: String = "res://src/Actors/Enemy.tscn"
export var speed_factor: = Vector2(1.0, 1.0)

var is_area_empty: = true
var with_enemies: = false

var factory: EnemyFactory

func _ready():
	if enemies_positions.size() > 0:
		with_enemies = true
		factory = EnemyFactory.new()
		factory.init(enemy_path, get_tree().get_current_scene(), enemies_positions)
		factory.instantiate()

func _on_LocationArea_body_entered(body: KinematicBody2D):
	if body and body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player entered on area")
		is_area_empty = false
		body.speed.x *= speed_factor.x
		body.speed.y *= speed_factor.y
		print("Now players speed = " + str(body.speed.x))


func _on_LocationArea_body_exited(body: KinematicBody2D):
	if body and body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player exited on area")
		is_area_empty = true
		body.speed.x /= speed_factor.x
		body.speed.y /= speed_factor.y
		print("Now players speed = " + str(body.speed.x))
		if with_enemies:
			enemy_respawn_coroutine()

func enemy_respawn_coroutine() -> void:
	var thick: = 0.1
	var time: = 0.0
	var timer = Timer.new()
	timer.set_wait_time(thick)
	timer.set_one_shot(true)
	self.add_child(timer)
	while is_area_empty and time < Constants.ENEMY_RESPAWN_TIME:
		timer.start()
		yield(timer, "timeout")
		#yield(get_tree().create_timer(thick), "timeout")
		time += thick
	timer.queue_free()
	if is_area_empty:
		factory.instantiate()
