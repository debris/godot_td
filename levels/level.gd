extends Node2D
class_name Level

const PATH_LAYER: int = 0
const SLOTS_LAYER: int = 1
const START_LAYER: int = 2
const END_LAYER: int = 3

@onready var tilemap: TileMap = $TileMap
@onready var towers: Node2D = $Towers

var start_cells = null
var end_cells = null
var towers_by_index = {}

func _ready():
	var path_layer = tilemap.get_layer_name(PATH_LAYER)
	var slots_layer = tilemap.get_layer_name(SLOTS_LAYER)
	var start_layer = tilemap.get_layer_name(START_LAYER)
	var end_layer = tilemap.get_layer_name(END_LAYER)
	assert(path_layer == "path", "layer 0 should be path")
	assert(slots_layer == "slots", "layer 1 should be slots")
	assert(start_layer == "start", "layer 2 should be start")
	assert(end_layer == "end", "layer 3 should be end")

	start_cells = tilemap.get_used_cells(START_LAYER)
	end_cells = tilemap.get_used_cells(END_LAYER)
	spawn_unit()

func normalize_position(pos: Vector2) -> Vector2:
	var index = tilemap.local_to_map(pos)
	return tilemap.map_to_local(index)

func get_center() -> Vector2:
	var cells = tilemap.get_used_cells(PATH_LAYER)
	var lowest_x = -1
	var lowest_y = -1
	var highest_x = -1
	var highest_y = -1

	for cell in cells:
		if lowest_x == -1 || lowest_x > cell.x:
			lowest_x = cell.x

		if lowest_y == -1 || lowest_y > cell.y:
			lowest_y = cell.y
		
		if highest_x == -1 || highest_x < cell.x:
			highest_x = cell.x

		if highest_y == -1 || highest_y < cell.y:
			highest_y = cell.y

	# / 2 * 32
	return (Vector2(lowest_x, lowest_y) + Vector2(highest_x, highest_y)) * 16 + Vector2(16, 16)

func spawn_unit():
	var unit = Unit.new()
	unit.position = start_cells.pick_random() * Vector2i(32, 32) + Vector2i(16, 16)
	unit.target_position = end_cells.pick_random() * Vector2i(32, 32) + Vector2i(16, 16)
	add_child(unit)
	unit.goal_reached.connect(func():
		unit.queue_free()
	)

func _on_menu_add_tower():
	add_child(AddTower.new(Tower.new))

func _on_menu_add_tower_2():
	add_child(AddTower.new(TowerT2.new))

func can_add_tower_at(pos: Vector2i) -> bool:
	# check if there is a slot
	if tilemap.get_cell_source_id(SLOTS_LAYER, pos) == -1:
		return false
	
	return !towers_by_index.has(pos) 

func remove_tower_at(pos: Vector2i):
	if towers_by_index.has(pos):
		var tower = towers_by_index[pos]
		tower.queue_free()
		towers_by_index.erase(pos)

func add_tower_at(pos: Vector2i, tower: Node2D):
	assert(!towers_by_index.has(pos))
	towers_by_index[pos] = tower

func _on_menu_remove():
	add_child(DeleteTower.new())