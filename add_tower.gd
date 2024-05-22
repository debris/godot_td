extends Node2D
class_name AddTower

signal tower_added
signal cancelled

@export var tower_constructor: Callable

var tower: Node2D = null

func _init(tc):
	tower_constructor = tc

func _ready():
	tower = tower_constructor.call()
	get_parent().add_child(tower)

	var mouse_position = get_global_mouse_position()
	tower.position = get_parent().normalize_position(mouse_position)

func _process(_delta):
	var mouse_position = get_global_mouse_position()
	var index = get_parent().tilemap.local_to_map(mouse_position)
	tower.position = get_parent().tilemap.map_to_local(index)

	if !get_parent().can_add_tower_at(index):
		tower.modulate = Color.BLACK
		tower.modulate.a = 0.2
	else:
		tower.modulate = Color.WHITE
		if Input.is_action_just_pressed("left_click"):
			print_debug("place tower")
			var old_pos = tower.position
			tower.active = true
			get_parent().add_tower_at(index, tower)
			tower_added.emit()
			tower = tower_constructor.call()
			tower.position = old_pos
			get_parent().add_child(tower)
	
	if Input.is_action_just_pressed("right_click"):
		queue_free()
		cancelled.emit()

func _exit_tree():
	tower.queue_free()
