extends Node
class_name AddTower

signal tower_added
signal cancelled

@export var tower_constructor: Callable
@export var level: Level

var tower: Node2D = null

func _ready():
	tower = tower_constructor.call()
	level.add_child(tower)

	tower.position = level.index_to_position(level.mouse_index())

func _process(_delta):
	var index = level.mouse_index()
	tower.position = level.index_to_position(index)

	if !level.can_add_tower_at(index):
		tower.modulate = Color.BLACK
		tower.modulate.a = 0.2
	else:
		tower.modulate = Color.WHITE
		if Input.is_action_just_pressed("left_click"):
			var old_pos = tower.position
			tower.active = true
			level.add_tower_at(index, tower)
			tower_added.emit()
			tower = tower_constructor.call()
			tower.position = old_pos
			level.add_child(tower)
	
	if Input.is_action_just_pressed("right_click"):
		queue_free()
		cancelled.emit()

func _exit_tree():
	tower.queue_free()
