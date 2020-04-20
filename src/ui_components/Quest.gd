extends CanvasLayer

class_name CanvasQuest

const PIECES_COUNT: = 6
const OPTION_MARGIN: = 30

var first: = Fraction.new()
var second: = Fraction.new()
var result: = Fraction.new()

var first_num_label
var first_denom_label
var second_num_label
var second_denom_label
var res_num_label
var res_denom_label

var lost_piece  
var held_object = null
var map_piece_script = null


func _ready():
	bind_nodes()
	reload()

func bind_nodes():
	first_num_label = get_node("TornMap/FirstNum/Label")
	first_denom_label = get_node("TornMap/FirstDenom/Label")
	second_num_label = get_node("TornMap/SecondNum/Label")
	second_denom_label = get_node("TornMap/SecondDenom/Label")
	res_num_label = get_node("TornMap/ResNum/Label")
	res_denom_label = get_node("TornMap/ResDenom/Label")
	map_piece_script = load("res://src/etc/quests/Map_Piece.gd")
	

func reload():
	randomize()
	reload_fractions()
	update_labels()
	reload_lost_piece()

func reload_lost_piece():
	var lost_piece_index =  randi() % PIECES_COUNT
	if lost_piece_index == 0:
		lost_piece = get_node("TornMap/FirstNum") 
	elif lost_piece_index == 1:
		lost_piece = get_node("TornMap/FirstDenom")
	elif lost_piece_index == 2:
		lost_piece = get_node("TornMap/SecondNum")
	elif lost_piece_index == 3:
		lost_piece = get_node("TornMap/SecondDenom")
	elif lost_piece_index == 4:
		lost_piece = get_node("TornMap/ResNum")
	elif lost_piece_index == 5:
		lost_piece = get_node("TornMap/ResDenom")
	lost_piece.visible = false
	create_options()

#create lost map piece duplicates as options with different values 
func create_options():
	var x_offset = 0.0   #offset for option position
	var existed_values: Array   # values that already presents in options list
	existed_values.append(lost_piece.get_node("Label").text)	# save correct value as already existed
	var correct_option_index = randi() % Constants.QUEST_OPTIONS_COUNT  # correct answer index in options list
	for i in Constants.QUEST_OPTIONS_COUNT:
		var duplicate = lost_piece.duplicate() 
		duplicate.visible = true 
		duplicate.global_transform.origin = get_node("OptionsArea").get_global_transform().origin		
		duplicate.set_position(Vector2(x_offset, 0))
		duplicate.get_node("CollisionShape2D").disabled = false
#		duplicate.translate(duplicate.get_transform().basis.xform(Vector2(x_offset, 0)))
		if i != correct_option_index:
			#this option should be wrong
			var is_unique: = false
			var new_text: String
			while not is_unique:
				new_text = str(randi() % 10 + 1)
				is_unique = true
				for i in existed_values:
					if i == new_text:
						is_unique = false
						break
			existed_values.append(new_text)
			duplicate.get_node("Label").text = new_text
		duplicate.connect("clicked", self, "_on_pickable_clicked")
		var object_width = 2 * duplicate.get_node("CollisionShape2D").get_shape().get_extents().x
		x_offset += object_width + OPTION_MARGIN
#		print("Node width is " + str(object_width))
		#get_node("OptionsArea").call_deferred("add_child", duplicate)
		get_tree().get_current_scene().call_deferred("add_child", duplicate)

func reload_fractions():
	var first_denom = randi() % (Constants.QUEST_DENOM_HIGH_LIMIT + 1) + Constants.QUEST_DENOM_LOW_LIMIT
	first.denom = first_denom
	second.denom = first_denom
	result.denom = first_denom
	first.num = randi() % (Constants.QUEST_NUM_HIGH_LIMIT + 1) + Constants.QUEST_NUM_LOW_LIMIT
	second.num = randi() % (Constants.QUEST_NUM_HIGH_LIMIT + 1) + Constants.QUEST_NUM_LOW_LIMIT
	result.add(first)
	result.add(second, true)

func update_labels():
	first_num_label.text = str(first.num)
	first_denom_label.text = str(first.denom)
	second_num_label.text = str(second.num)
	second_denom_label.text = str(second.denom)
	res_num_label.text = str(result.num)
	res_denom_label.text = str(result.denom)

func _on_pickable_clicked(object):
	if !held_object:
		held_object = object
		held_object.pickup()

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if held_object and !event.is_pressed():
			held_object.drop()
			held_object = null


func _on_MapArea_body_entered(body):
	body.area_entrance(true)
	print("entry")


func _on_MapArea_body_exited(body):
	print("exit")
	if body.is_in_area():
		body.area_entrance(false)
