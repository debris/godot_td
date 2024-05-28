extends Node
class_name TowerMove

@export var tower: Tower
@export var level: Level

var from_index: Vector2i
var to_index: Vector2i

func _ready():
	from_index = level.mouse_index()
	to_index = from_index
	tower.position = level.index_to_position(from_index)

func _process(_delta):
	var index = level.mouse_index()

	if from_index == index || level.can_add_tower_at(index):
		to_index = index
		tower.position = level.index_to_position(index)
		
	if Input.is_action_just_released("left_click"):
		level.move_tower(from_index, to_index)
		queue_free()
