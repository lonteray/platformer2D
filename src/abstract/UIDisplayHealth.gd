extends CanvasLayer

class_name UIDisplayHealth

var progress: = 0
var time: = 0.0
var is_game_over: = false

const MINUTE: = 60

const TIMER_STEP: = 1.0

func _ready():
	var timer = get_node("Timer")
	timer_coroutine(timer)

func update_label(num: int, denom: int) -> void:
	var text = str(num) + '/' + str(denom)
	get_node("HealthLabel").text = text

func update_status(value: float) -> void:
	progress = int(value * 1000.0)
	get_node("HealthStatus").value = progress

func timer_coroutine(timer) -> void:
	var t = Timer.new()
	t.set_wait_time(TIMER_STEP)
	t.set_one_shot(true)
	self.add_child(t)
	while !is_game_over:
#		var minutes: = int(time / MINUTE)
#		timer.text = ""
#		if minutes > 0:
#			timer.text += str(minutes) + "m "
#		var seconds = time - (minutes * MINUTE)
		timer.text = convert_time_to_string()
		time += TIMER_STEP
		t.start()
		yield(t, "timeout")
		#yield(get_tree().create_timer(TIMER_STEP), "timeout")
	t.queue_free()

func game_over() -> void:
	is_game_over = true
	get_node("GameOver/Menu/MainLabel").text += convert_time_to_string()
	get_node("GameOver").visible = true

func is_game_over() -> bool:
	return is_game_over

func convert_time_to_string() -> String:
	var result: = ""
	var minutes: = int(time / MINUTE)
	if minutes > 0:
		result += str(minutes) + "m "
	var seconds = time - (minutes * MINUTE)
	result += str(seconds) + "s"
	return result
