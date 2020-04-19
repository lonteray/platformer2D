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

func _ready():
	bind_nodes()
	reload()

func bind_nodes():
	first_num_label = get_node("TornMap/FirstNumTexture/Label")
	first_denom_label = get_node("TornMap/FirstDenomTexture/Label")
	second_num_label = get_node("TornMap/SecondNumTexture/Label")
	second_denom_label = get_node("TornMap/SecondDenomTexture/Label")
	res_num_label = get_node("TornMap/ResNumTexture/Label")
	res_denom_label = get_node("TornMap/ResDenomTexture/Label")
	

func reload():
	randomize()
	reload_fractions()
	update_labels()
	reload_lost_piece()

func reload_lost_piece():
	var lost_piece_index =  randi() % PIECES_COUNT
	if lost_piece_index == 0:
		lost_piece = get_node("TornMap/FirstNumTexture") 
	elif lost_piece_index == 1:
		lost_piece = get_node("TornMap/FirstDenomTexture")
	elif lost_piece_index == 2:
		lost_piece = get_node("TornMap/SecondNumTexture")
	elif lost_piece_index == 3:
		lost_piece = get_node("TornMap/SecondDenomTexture")
	elif lost_piece_index == 4:
		lost_piece = get_node("TornMap/ResNumTexture")
	elif lost_piece_index == 5:
		lost_piece = get_node("TornMap/ResDenomTexture")
	lost_piece.visible = false
	create_options()

func create_options():
	var x_offset = 0.0
	var existed_values: Array
	existed_values.append(lost_piece.get_node("Label").text)
	var correct_option_index = randi() % Constants.QUEST_OPTIONS_COUNT
	for i in Constants.QUEST_OPTIONS_COUNT:
		var duplicate = lost_piece.duplicate()
		duplicate.visible = true
		duplicate.set_position(Vector2(x_offset, 0))
		if i != correct_option_index:
			var is_good: = false
			var new_text: String
			while not is_good:
				new_text = str(randi() % 10 + 1)
				is_good = true
				for i in existed_values:
					if i == new_text:
						is_good = false
						break
			existed_values.append(new_text)
			duplicate.get_node("Label").text = new_text
		x_offset += duplicate.get_size().x + OPTION_MARGIN
		get_node("OptionsPanel").call_deferred("add_child", duplicate)

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
	
	
	
	
