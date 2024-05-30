@tool
extends Node2D
class_name SlotRange

func _ready():
	var square = Square.new()
	square.color = GameColor.SLOT
	square.border_color = GameColor.BORDER
	add_child(square)

	var circle = Circle.new()
	circle.radius = 8.0
	circle.color = GameColor.BUFF
	add_child(circle)
