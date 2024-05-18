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
	var size = Vector2(16.0, 16.0)

	var square = Square.new()
	square.size = size
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
	area.set_collision_layer_value(GameLayer.ENEMY, true)
	area.set_collision_mask_value(GameLayer.BULLET, true)
	add_child(area)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = size
	area.add_child(collision_shape)

	area.area_entered.connect(func(body):
		# hit by the bullet
		if body is DamageArea:
			print_debug("taking " + str(body.damage) + " damage")
			# TODO: implement damage
		queue_free()	
	)
