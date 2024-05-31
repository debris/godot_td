extends Node2D
class_name TowerDelete

var square = Square.new()

func _ready():
	square.color = Color.WHITE
	square.color.a = 0
	square.border_color = Color.WHITE
	add_child(square)

func _process(_delta):
	var mouse_position = get_global_mouse_position()

	# normalize position so it's always a square
	square.position = get_parent().normalize_position(mouse_position)

	if Input.is_action_just_pressed("left_click"):
		get_parent().remove_tower_at(get_parent().tilemap.local_to_map(mouse_position))
	
	if Input.is_action_just_pressed("right_click"):
		queue_free()
