extends CanvasLayer

class_name UIDisplayHealth

func update_label(health: Fraction) -> void:
	var text = str(health.num) + '/' + str(health.denom)
	get_node("HealthLabel").text = text
