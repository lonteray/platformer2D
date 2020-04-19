extends StaticBody2D

signal clicked

var held = false
var start_position: Vector2

func _ready():
	input_pickable = true

func _input_event(viewport, event, shape_idx):
	print("Feeeee")
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			print("fooooooo")
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
	print("Map piece was dropped")
	held = false
	set_position(start_position)
