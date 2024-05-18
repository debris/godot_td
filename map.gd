extends Node2D

@onready var ground = $Ground
@onready var camera = $Camera2D

@onready var score_label = $Menu/Score
@onready var to_emit_label = $Menu/ToEmit
@onready var start_button = $Menu/Start

var hp := 30:
	set(value):
		hp = value
		_update_score()

var square_by_index = {}
var path = MapGenerator.generate_map()

func _update_score():
	score_label.text = "score: " + str(hp)

func _update_to_emit():
	# update to emit
	to_emit_label.text = "to emit: " + "?" #str(spawn.limit)

func _ready():
	_update_score()
	_update_to_emit()
		
	for square_index in path:
		var square = Square.new()
		square.color = GameColor.PATH
		square.border_color = GameColor.BORDER
		add_square(square, square_index)

func _on_start_pressed():
	#start_button.visible = false
	
	var spawn = Spawn.new()
	add_child(spawn)
	
	spawn.spawn.connect(func(u: Unit): 
		_update_to_emit()
		ground.add_child(u)
		u.path = path
		u.goal_reached.connect(func(): 
			hp -= 1
		)
	)

func add_square(node: Node2D, index: Vector2):
	ground.add_child(node)
	node.position = Utils.index_to_position(index)
	# TODO: fix
	#assert(!has_square(index), "overwritting square")
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
			square_by_index.erase(index)


func _on_remove_pressed():
	add_child(DeleteTower.new())

func _on_tower_pressed():
	# add delay so 'AddTower' doesnt process the same button press
	await get_tree().create_timer(0.05).timeout
	add_child(AddTower.new(Tower.new))

func _on_tower_2_pressed():
	# add delay so 'AddTower' doesnt process the same button press
	await get_tree().create_timer(0.05).timeout
	add_child(AddTower.new(TowerT2.new))
