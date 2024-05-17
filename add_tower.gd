extends Node2D
class_name AddTower

var tower = Tower.new()

func _ready():
	get_parent().add_child(tower)

func _process(_delta):
	var mouse_position = get_global_mouse_position()

	# normalize position so it's always a square
	tower.position = Utils.index_to_position(Utils.position_to_index(mouse_position))

	if Input.is_action_just_pressed("left_click"):
		if !get_parent().has_square(Utils.position_to_index(mouse_position)):
			print_debug("place tower")
			get_parent().save_square(tower, Utils.position_to_index(mouse_position))
			var tower_position = tower.position
			tower = Tower.new()
			tower.position = tower_position
			get_parent().add_child(tower)
	
	if Input.is_action_just_pressed("right_click"):
		tower.queue_free()
		queue_free()