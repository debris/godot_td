@tool
extends Node2D
class_name SlotDamage

func _ready():
	var square = Square.new()
	square.color = GameColor.SLOT
	square.border_color = GameColor.BORDER
	add_child(square)

	var inner = Square.new()
	inner.size = Vector2(12.0, 12.0)
	inner.color = GameColor.BUFF
	inner.border_color = GameColor.BUFF
	add_child(inner)
