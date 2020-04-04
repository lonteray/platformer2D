extends Area2D

class_name LocationArea

export var enemies_count: = 0
export var left_enemy_position: Vector2
export var right_enemy_position: Vector2

var is_area_empty: = true
var enemy_instance: Enemy


func _on_LocationArea_body_entered(body: KinematicBody2D):
	if body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player entered on area")


func _on_LocationArea_body_exited(body: KinematicBody2D):
	if body.collision_layer == Constants.PLAYER_LEVEL:
		print("Player exited on area")
