@tool
extends Node2D
class_name Unit

signal goal_reached

@export var path: PackedVector2Array:
	set(value):
		path = value
		follow_path.path = path

var follow_path = FollowPath.new()

func _ready():
	var square = Square.new()
	square.color = GameColor.ENEMY
	square.border_color = GameColor.BORDER
	add_child(square)

	follow_path.path = path
	square.add_child(follow_path)
	follow_path.finished.connect(func():
		goal_reached.emit()
		queue_free()
	)
