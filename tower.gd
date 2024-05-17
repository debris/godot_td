@tool
extends Node2D
class_name Tower

@export var radius:= 64.0:
	set(value):
		radius = value

var size = Vector2(32.0, 32.0)

func _ready():
	var square = Square.new()
	square.size = size
	square.color = Color.RED
	add_child(square)

	var range_on_hover = DisplayRangeOnHover.new()
	add_child(range_on_hover)
