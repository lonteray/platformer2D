extends StaticBody2D

signal clicked

func _ready():
	print(input_pickable)
	connect("clicked", self, "click")

#func _on_MapPiece_input_event(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
#		print("Nigggaaa")
#		emit_signal("clicked", self)

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		emit_signal("clicked", self)

func click(object):
	print("Fooooo")
