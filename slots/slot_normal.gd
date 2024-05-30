@tool
extends Node2D
class_name SlotNormal

func _ready():
	var square = Square.new()
	square.color = GameColor.SLOT
	square.border_color = GameColor.BORDER
	add_child(square)
