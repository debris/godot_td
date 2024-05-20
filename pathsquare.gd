@tool
extends Node2D
class_name PathSquare

func _ready():
	var square = Square.new()
	square.color = GameColor.PATH
	square.border_color = GameColor.BORDER
	add_child(square)
