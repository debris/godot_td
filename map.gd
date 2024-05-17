extends Node2D

@onready var ground = $Ground
@onready var camera = $Camera2D

@onready var unit = $Unit
@onready var unit_path = $Unit/FollowPath

@onready var score_label = $CanvasLayer/Score
@onready var to_emit_label = $CanvasLayer/ToEmit
@onready var start_button = $CanvasLayer/Start

var hp := 30:
	set(value):
		hp = value
		_update_score()

var square_by_index = {}

var spawn = Spawn.new()

func _update_score():
	score_label.text = "score: " + str(hp)

func _update_to_emit():
	to_emit_label.text = "to emit: " + str(spawn.limit)

func _ready():
	_update_score()
	_update_to_emit()

	var path = MapGenerator.generate_map()
		
	for square_index in path:
		var square = Square.new()
		square.color = GameColor.PATH
		square.border_color = GameColor.BORDER
		add_square(square, square_index)

	spawn.spawn.connect(func(u: Unit): 
		_update_to_emit()
		ground.add_child(u)
		u.path = path
		u.goal_reached.connect(func(): 
			hp -= 1
		)
	)
	unit_path.path = path

func _on_start_pressed():
	start_button.visible = false
	add_child(spawn)

func _on_tower_pressed():
	add_child(AddTower.new())

func add_square(node: Node2D, index: Vector2):
	ground.add_child(node)
	node.position = Utils.index_to_position(index)
	assert(!has_square(index), "overwritting square")
	square_by_index[index] = node

func save_square(node: Node2D, index: Vector2):
	assert(!has_square(index), "overwritting square")
	square_by_index[index] = node

func has_square(index: Vector2):
	return square_by_index.has(index)

func remove_square(index: Vector2):
	if square_by_index.has(index):
		if !square_by_index[index] is Square:
			square_by_index[index].queue_free()
			square_by_index[index] = null


func _on_remove_pressed():
	add_child(DeleteTower.new())
