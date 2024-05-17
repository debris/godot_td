@tool
extends Node2D
class_name Circle

@export var radius := 32.0:
	set(value):
		radius = value
		queue_redraw()

@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()

func _draw():
	draw_circle(Vector2.ZERO, radius, color)
