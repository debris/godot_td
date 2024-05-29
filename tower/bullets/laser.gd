extends Node2D
class_name Laser

@export var damage := 1
@export var distance_left := 100.0:
	set(value):
		distance_left = value
		queue_redraw()

func _draw():
	draw_line(Vector2.ZERO, Vector2(distance_left, 0.0), Color.RED, 6)
