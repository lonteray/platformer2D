extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 4000.0

var velocity: = Vector2.ZERO

var health: = Fraction.new()
var right_direction: = Vector2(speed.x, 0.0)
var left_direction: = Vector2(-speed.x, 0.0)

func _physics_process(delta):
	#gravity force calculating
	print("Actor method")
	if !is_on_floor():
		velocity.y += gravity * delta
		velocity.y = move_and_slide(velocity, FLOOR_NORMAL).y
	
func moveRight() -> void:
	right_direction.y = velocity.y
	move_and_slide(right_direction, FLOOR_NORMAL)
	
func moveLeft() -> void:
	left_direction.y = velocity.y
	move_and_slide(left_direction, FLOOR_NORMAL)
