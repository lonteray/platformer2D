extends Node

class_name EnemyFactory

var instance_scene
var target_scene: Node2D
var positions: PoolVector2Array
var instances: Array
var enemies_count: int

const SCALE: = 0.86

func init(path: String, iscene: Node2D, pos: PoolVector2Array) -> void:
	for i in pos:
		positions.append(i)
	enemies_count = pos.size()
	instance_scene = load(path)
	target_scene = iscene
	if not instance_scene:
		print("Scene with object was not found")
		return

func instantiate() -> void:
	if instances.empty():
		for position in positions:
			var instance = instance_scene.instance()
			set_node(instance, position)


func set_node(instance, position: Vector2) -> void:
			target_scene.call_deferred("add_child", instance)
			instance.set_position(position)
			instances.append(instance)

