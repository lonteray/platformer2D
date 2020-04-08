extends Node

class_name EnemyFactory

var instance_scene
var target_scene: Node2D
var positions: PoolVector2Array
var instances: Array
var enemies_count: int
var instance

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
		var count: = 0
		for position in positions:
			set_node(position, count)
			count += 1
		#print("count of instances = " + str(instances.size()))
		#display_instances()
	else:
		#print("count of instances = " + str(instances.size()))
		#print("Instances before checking")
		#display_instances()
		var index: = 0
		for i in range(instances.size()):
			if not is_instance_valid(instances[i]):
				#print("Enemy" + str(i) + " was died")
				instances.erase(instances[i])
				set_node(positions[index], i)
			index += 1

func set_node(position: Vector2, index: int) -> void:
	#print("Before insertion")
	#display_instances()
	instance = instance_scene.instance()
	target_scene.call_deferred("add_child", instance)
	instance.set_position(position)
	instances.insert(index, instance)
	#print("Newbie instance now has a position " + str(instances.find(instance)))
	#print("After insertion")
	#display_instances()

func display_instances() -> void:
#	var count = 0 
#	while count < instances.size():
#		print("Instance" + str(count) + " has position (" +  str(instances[count].position.x) + ", " + str(instances[count].position.y) + ")")
#		count += 1
	for i in range(instances.size()):
		if is_instance_valid(instances[i]):
			print("Instance" + str(i) + " has position (" +  str(instances[i].position.x) + ", " + str(instances[i].position.y) + ")")
		else:
			print("Instance" + str(i) + " does not exist")

func display_instance(index: int) -> void:
	print("Instance" + str(index) + " has position (" +  str(instances[index].position.x) + ", " + str(instances[index].position.y) + ")")
