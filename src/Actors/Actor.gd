extends KinematicBody2D
class_name Actor

const FLOOR_NORMAL: = Vector2.UP

export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 4000.0

var velocity: = Vector2.ZERO
#var is_on_fight: = false

var health: = Fraction.new()
var right_direction: = Vector2(speed.x, 0.0)
var left_direction: = Vector2(-speed.x, 0.0)

func _physics_process(delta):
	#gravity force calculating
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, FLOOR_NORMAL)
	
func move_right(intensity = 1.0) -> void:
	velocity.x = speed.x * intensity
	
func move_left(intensity = 1.0) -> void:
	velocity.x = -speed.x * intensity
	
func update_health_label() -> void:
	get_node("HealthLabel").text = str(health.num) + '/' + str(health.denom)

func die() -> void:
	get_node("CollisionShape2D").disabled = true
	queue_free()

func set_active(state: bool) -> void:
	set_physics_process(state)
	visible = state
	if state:
		move_and_slide(Vector2.ZERO)
