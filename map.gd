extends Node2D

@onready var ground = $Ground
@onready var camera = $Camera2D

@onready var spawn = $Spawn
@onready var unit = $Unit
@onready var unit_path = $Unit/FollowPath

@onready var score_label = $CanvasLayer/Score
@onready var to_emit_label = $CanvasLayer/ToEmit

var hp := 30:
	set(value):
		hp = value
		_update_score()

func _update_score():
	score_label.text = "score: " + str(hp)

func _update_to_emit():
	to_emit_label.text = "to emit: " + str(spawn.limit)

func _ready():
	_update_score()
	_update_to_emit()

	var path = MapGenerator.generate_map()
		
	for square_position in path:
		var square = Square.new()
		square.position = square_position
		add_child(square)

	spawn.spawn.connect(func(u: Unit): 
		_update_to_emit()
		add_child(u)
		u.path = path
		u.goal_reached.connect(func(): 
			hp -= 1
		)
	)
	unit_path.path = path
