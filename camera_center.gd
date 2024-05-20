extends Node

@export var level: Level

func _ready():
	var center = level.get_center()
	print_debug("center")
	print_debug(center)
	#get_parent().position = Vector2(200, 200)
	get_parent().position = level.get_center()
