extends Actor

class_name Enemy

var is_right_direction: = true

func _physics_process(delta: float) -> void:
	if is_on_floor():
		if is_right_direction:
			moveRight()
		else:
			moveLeft()
		if is_on_wall():
			if is_right_direction:
				is_right_direction = false
			else:
				is_right_direction = true
			

