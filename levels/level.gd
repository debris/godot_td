extends Node2D
class_name Level

signal cancel_card
signal card_used
signal wave_finished

const PATH_LAYER: int = 0
const SLOTS_LAYER: int = 1
const START_LAYER: int = 2
const END_LAYER: int = 3

@onready var tilemap: TileMap = $TileMap

var enemies_layer = Node2D.new()
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
	add_child(enemies_layer)

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
	unit.position = tilemap.map_to_local(start_cells.pick_random())
	unit.target_position = tilemap.map_to_local(end_cells.pick_random())
	enemies_layer.add_child(unit)
	unit.goal_reached.connect(func():
		unit.queue_free()
	)

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

func _on_menu_card_pressed(card: Card):
	var add_tower = AddTower.new(card.tower_constructor())
	add_tower.cancelled.connect(func():
		cancel_card.emit()
	)
	add_child(add_tower)
	await add_tower.tower_added
	add_tower.queue_free()
	card_used.emit()

func _on_menu_start_wave(units: int):
	var wave = Wave.new()
	wave.tilemap = tilemap
	wave.enemies_layer = enemies_layer
	wave.start_cells = start_cells
	wave.end_cells = end_cells
	wave.units = units
	add_child(wave)
	await wave.wave_finished
	wave.queue_free()
	wave_finished.emit()
