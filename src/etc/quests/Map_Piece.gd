extends TextureRect

signal clicked

var held = false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			emit_signal("clicked", self)

func _physics_process(delta):
	if held:
		set_position(get_global_mouse_position())

func pickup():
	if held:
		return
	held = true

func drop():
	print("Map piece was dropped")
	held = false

