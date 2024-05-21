class_name DisplaySquareTooltip
extends Node

@export var text: String = ""
var tooltip = null

func _ready():
	var static_body = StaticBody2D.new()
	static_body.input_pickable = true
	get_parent().add_child.call_deferred(static_body)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(32.0, 32.0)
	static_body.add_child(collision_shape)

	static_body.mouse_entered.connect(func():
		assert(tooltip == null, "tooltip should be removed")
		tooltip = Tooltip.new()
		tooltip.z_index = 1
		tooltip.text = text
		get_parent().add_child(tooltip)
	)

	static_body.mouse_exited.connect(func():
		tooltip.queue_free()	
		tooltip = null
	)
