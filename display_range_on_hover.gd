@tool
extends Node
class_name DisplayRangeOnHover

func _ready():
	var parent = get_parent()

	if !"radius" in parent:
		print_debug("cannot display range, missing parent radius")

	if !"size" in parent:
		print_debug("cannot display range, missing parent size")

	var static_body = StaticBody2D.new()
	static_body.input_pickable = true
	parent.add_child(static_body)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = parent.size
	static_body.add_child(collision_shape)

	var circle = Circle.new()
	circle.color = Color.PURPLE
	circle.color.a = 0.3
	circle.visible = false
	parent.add_child(circle)

	static_body.mouse_entered.connect(func():
		circle.radius = parent.radius
		circle.visible = true
	)

	static_body.mouse_exited.connect(func():
		circle.visible = false
	)
