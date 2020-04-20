extends StaticBody2D

signal clicked

var held = false
var start_position: Vector2
var mapArea: Area2D
var in_area: = false

func _ready():
	input_pickable = true
	mapArea = get_tree().get_current_scene().find_node("MapArea")

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(delta):
	if held:
		global_transform.origin = get_global_mouse_position()

func pickup():
	if held:
		return
	held = true
	start_position = position

func drop():
	held = false
	if in_area:
		print("Piece was in area")
	#set_position(start_position)

func area_entrance(state: bool):
	in_area = state

func is_in_area():
	return in_area
