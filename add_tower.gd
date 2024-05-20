extends Node2D
class_name AddTower

@export var tower_constructor: Callable

var tower: Node2D = null

func _init(tc):
	tower_constructor = tc

func _ready():
	tower = tower_constructor.call()
	get_parent().add_child(tower)

	var mouse_position = get_global_mouse_position()
	var index = Utils.position_to_index(mouse_position)
	tower.position = Utils.index_to_position(index)

func _process(_delta):
	var mouse_position = get_global_mouse_position()
	var index = Utils.position_to_index(mouse_position)
	tower.position = Utils.index_to_position(index)

	if get_parent().has_square(index):
		tower.modulate = Color.BLACK
		tower.modulate.a = 0.2
	else:
		tower.modulate = Color.WHITE
		if Input.is_action_just_pressed("left_click"):
			print_debug("place tower")
			tower.active = true
			get_parent().save_square(tower, index)
			var tower_position = tower.position
			tower = tower_constructor.call()
			tower.position = tower_position
			get_parent().add_child(tower)
	
	if Input.is_action_just_pressed("right_click"):
		tower.queue_free()
		queue_free()
	
