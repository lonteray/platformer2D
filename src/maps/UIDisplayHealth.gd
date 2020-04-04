extends CanvasLayer

class_name UIDisplayHealth

var progress: = 0
var time: = 0.0
var is_game_over: = false

const TIMER_STEP: = 1.0

func _ready():
	timer_coroutine()

func update_label(num: int, denom: int) -> void:
	var text = str(num) + '/' + str(denom)
	get_node("HealthLabel").text = text

func update_status(value: float) -> void:
	progress = int(value * 1000.0)
	get_node("HealthStatus").value = progress

func timer_coroutine() -> void:
	while !is_game_over:
		get_node("Timer").text = str(time) + ".0"
		time += TIMER_STEP
		yield(get_tree().create_timer(TIMER_STEP), "timeout")

func game_over() -> void:
	is_game_over = true
