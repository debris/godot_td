@tool
extends Node
class_name TowerMouseHover

signal mouse_entered
signal mouse_exited

@export var tower: Tower

func is_hovered() -> bool:
	return hovered

var hovered = false

func _ready():
	var static_body = StaticBody2D.new()
	static_body.input_pickable = true
	static_body.collision_layer = 1
	static_body.collision_mask = 1
	tower.add_child(static_body)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(32.0, 32.0)
	static_body.add_child(collision_shape)

	static_body.mouse_entered.connect(func():
		hovered = true	
		mouse_entered.emit()
	)

	static_body.mouse_exited.connect(func():
		hovered = false	
		mouse_exited.emit()
	)
