extends Area2D

class_name LocationArea

#export var enemies_count: = 0
#export var left_enemy_position: Vector2
#export var right_enemy_position: Vector2
export var enemies_positions: PoolVector2Array
export var enemy_path: String = "res://src/Actors/Enemy.tscn"

var is_area_empty: = true
var factory: = EnemyFactory.new()

func _ready():
	factory.init(enemy_path, get_tree().get_current_scene(), enemies_positions)
	factory.instantiate()

func _on_LocationArea_body_entered(body: KinematicBody2D):
	if body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player entered on area")
		is_area_empty = false


func _on_LocationArea_body_exited(body: KinematicBody2D):
	if body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player exited on area")
		is_area_empty = true
		factory.instantiate()
