@tool
extends Node
class_name CircleRange

signal enemy_in_range(pos: Vector2)

var last_enemy = null

func _ready():
	var parent = get_parent()

	if !"radius" in parent:
		print_debug("cannot display range, missing parent radius")

	if !"size" in parent:
		print_debug("cannot display range, missing parent size")

	var static_body = StaticBody2D.new()
	static_body.input_pickable = true
	static_body.collision_layer = 1
	static_body.collision_mask = 1
	parent.add_child(static_body)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = parent.size
	static_body.add_child(collision_shape)

	var circle = Circle.new()
	circle.color = GameColor.TOWER_RANGE
	circle.color.a = 0.3
	circle.visible = false
	circle.radius = parent.radius
	parent.add_child(circle)

	var area = Area2D.new()
	area.collision_layer = 0
	area.collision_mask = 0
	# TODO: 2 should be a constant
	area.set_collision_mask_value(2, true)
	parent.add_child(area)

	var range_shape = CollisionShape2D.new()
	range_shape.shape = CircleShape2D.new()
	# TODO: update if it changes with parent
	range_shape.shape.radius = parent.radius
	area.add_child(range_shape)

	static_body.mouse_entered.connect(func():
		print_debug("hover tower")
		circle.radius = parent.radius
		circle.visible = true
	)

	static_body.mouse_exited.connect(func():
		circle.visible = false
	)

	area.area_entered.connect(func(body):
		last_enemy = body
		print_debug("enemy in range")
	)

	area.area_exited.connect(func(body):
		print_debug("enemy exited")	
		if body == last_enemy:
			last_enemy = null
	)

func _process(_delta):
	if last_enemy != null:
		enemy_in_range.emit(last_enemy.global_position)
