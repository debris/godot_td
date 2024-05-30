@tool
extends Node2D
class_name Square

@export var size := Vector2(32.0, 32.0):
	set(value):
		size = value
		queue_redraw()

@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()

@export var border_color := Color.BLACK:
	set(value):
		border_color = value
		queue_redraw()

func _draw():
	draw_rect(Rect2(-size / 2, size), color)
	draw_rect(Rect2(-size / 2, size), border_color, false, 2.0)