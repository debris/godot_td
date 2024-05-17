extends Node2D
class_name DeleteTower

var square = Square.new()

func _ready():
	square.color = Color.WHITE
	square.color.a = 0
	square.border_color = Color.WHITE
	add_child(square)

func _process(_delta):
	var mouse_position = get_global_mouse_position()

	# normalize position so it's always a square
	square.position = Utils.index_to_position(Utils.position_to_index(mouse_position))

	if Input.is_action_just_pressed("left_click"):
		if get_parent().has_square(Utils.position_to_index(mouse_position)):
			print_debug("remove tower")
			get_parent().remove_square(Utils.position_to_index(mouse_position))
	
	if Input.is_action_just_pressed("right_click"):
		queue_free()