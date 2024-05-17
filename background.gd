@tool
extends Node2D
class_name Background

@export var size := Vector2(256.0, 256.0):
	set(value):
		size = value
		queue_redraw()

func _draw():
	draw_rect(Rect2(-size / 2, size), GameColor.BACKGROUND)
