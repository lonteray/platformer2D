extends CanvasLayer

class_name UIDisplayHealth

var progress: = 0
var time: = 0.0

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
	while true:
		yield(get_tree().create_timer(TIMER_STEP), "timeout")
		time += TIMER_STEP
		get_node("TestTimer").text = str(time)
