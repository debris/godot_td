extends Node
class_name Wave

signal life_lost
signal wave_finished

@export var tilemap: TileMap
@export var enemies_layer: Node2D
@export var start_cells: Array[Vector2i]
@export var end_cells: Array[Vector2i]
@export var units: int

var spawn = Spawn.new()
var left := 0
var finished_spawning = false

func _ready():
	spawn.limit = units
	add_child(spawn)

	spawn.spawn.connect(func(unit):
		left += 1
		unit.position = tilemap.map_to_local(start_cells.pick_random())
		unit.target_position = tilemap.map_to_local(end_cells.pick_random())
		unit.goal_reached.connect(func():
			life_lost.emit()
			unit.queue_free()
		)
		enemies_layer.add_child(unit)
	)

	enemies_layer.child_exiting_tree.connect(func(_child):
		left -= 1
		if finished_spawning && left == 0:
			wave_finished.emit()
	)

	await spawn.finished
	finished_spawning = true
