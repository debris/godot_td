extends Node2D
class_name LoadBar

signal finished

@export var size := Vector2(24.0, 4.0):
	set(v):
		size = v
		queue_redraw()

@export_range(0.0, 1.0) var value := 0.0:
	set(v):
		value = min(v, 1.0)
		queue_redraw()

		if value >= 1.0:
			finished.emit()

@export var time := 1.0

func _process(delta):
	if Pause.paused:
		return

	value += delta / time

func _draw():
	draw_rect(Rect2(-size / 2, size * Vector2(value, 1.0)), Color.WHITE, true)
