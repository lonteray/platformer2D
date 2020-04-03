extends Label

func _ready():
	text = str(get_parent().health.num) + '/' + str(get_parent().health.denom)

