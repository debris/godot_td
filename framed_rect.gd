@tool
extends Control
class_name FramedRect

@export var color := GameColor.BACKGROUND:
	set(value):
		color = value
		queue_redraw()

func _draw():
	if size.is_zero_approx():
		return

	var frame_width = 2.0
	var x_offset = Vector2(frame_width / 2.0, 0)
	draw_rect(Rect2(Vector2.ZERO, size), color, true)
	draw_line(Vector2.ZERO - x_offset, Vector2(size.x, 0) + x_offset, GameColor.FRAME_UP, frame_width)
	draw_line(Vector2.ZERO, Vector2(0, size.y), GameColor.FRAME_UP, frame_width)
	draw_line(size + x_offset, Vector2(0, size.y) - x_offset, GameColor.FRAME_DOWN, frame_width)
	draw_line(size, Vector2(size.x, 0), GameColor.FRAME_DOWN, frame_width)
	draw_line(Vector2(size.x, 0) - x_offset, Vector2(size.x, 0) + x_offset, GameColor.FRAME_CORNER, frame_width)
	draw_line(Vector2(0, size.y) - x_offset, Vector2(0, size.y) + x_offset, GameColor.FRAME_CORNER, frame_width)
