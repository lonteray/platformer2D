extends Sprite

class_name FightCloud

var textures = Array()

func _ready():
	load_textures()

func load_textures() -> void:
	textures.append(preload("res://assets/fight_cloud/fight_cloud_0.png"))
	textures.append(preload("res://assets/fight_cloud/fight_cloud_1.png"))
	textures.append(preload("res://assets/fight_cloud/fight_cloud_2.png"))
	textures.append(preload("res://assets/fight_cloud/fight_cloud_3.png"))

func set_active(state: bool, first_actor_pos = Vector2.ZERO, second_actor_pos = Vector2.ZERO) -> void:
	visible = state
	if state:
		var cloud_pos: = Vector2.ZERO
		cloud_pos.x = (first_actor_pos.x + second_actor_pos.x) / 2
		cloud_pos.y = (first_actor_pos.y + second_actor_pos.y) / 2
		position = cloud_pos + Constants.FIGHT_CLOUD_OFFSET
		fight_cloud_coroutine()

func fight_cloud_coroutine() -> void:
	var thick = Constants.FIGHT_TIME / textures.size()
	var timer = Timer.new()
	timer.set_wait_time(thick)
	timer.set_one_shot(true)
	self.add_child(timer)
	for i in textures.size():
		set_texture(textures[i])
		timer.start()
		yield(timer, "timeout")
		timer.queue_free()
		#yield(get_tree().create_timer(0.25), "timeout")
