@tool
extends Node2D
class_name Unit

signal goal_reached

@export var path: PackedVector2Array:
	set(value):
		path = value
		follow_path.path = path

@export var health := Health.new()

var follow_path = FollowPath.new()

func _ready():
	var size = Vector2(16.0, 16.0)

	var square = Square.new()
	square.size = size
	square.color = GameColor.ENEMY
	square.border_color = GameColor.BORDER
	add_child(square)

	var head = Square.new()
	head.size = Vector2(8.0, 6.0)
	head.position = Vector2(0.0, -8.0)
	head.color = GameColor.ENEMY
	head.border_color = GameColor.BORDER
	square.add_child(head)

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
			health.current -= body.damage
	)

	health.death.connect(func():
		print_debug("killed")
		queue_free()
	)

	var bar = Bar.new()
	bar.position = Vector2(0.0, 12.0)
	bar.value = 0.0
	add_child(bar)

	health.changed.connect(func():
		bar.value = health.percent()
	)
