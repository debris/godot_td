@tool
extends Node2D
class_name SlotSpeed

func _ready():
	var square = Square.new()
	square.color = GameColor.SLOT
	square.border_color = GameColor.BORDER
	add_child(square)

	var sprite = Sprite2D.new()
	sprite.texture = preload("res://res/bolt.svg")
	sprite.scale = Vector2(0.040, 0.040)
	sprite.modulate = GameColor.BUFF
	add_child(sprite)
