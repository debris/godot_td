## Drawing of Shape2D
@tool
extends Node2D
class_name VisualShape

@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()

@export var shape: Shape2D:
	set(value):
		shape = value
		shape.changed.connect(func(): queue_redraw())
		queue_redraw()

func _draw():
	shape.draw(get_canvas_item(), color)
