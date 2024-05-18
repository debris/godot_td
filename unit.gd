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
	add_child(follow_path)
	follow_path.finished.connect(func():
		goal_reached.emit()
		queue_free()
	)

	var area = Area2D.new()
	area.collision_layer = 0
	area.collision_mask = 0
	# TODO: make 2 const somewhere
	area.set_collision_layer_value(2, true)
	add_child(area)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(32.0, 32.0)
	area.add_child(collision_shape)
