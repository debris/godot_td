@tool
extends Node2D
class_name Tower

@export var radius:= 64.0:
	set(value):
		radius = value

var size = Vector2(32.0, 32.0)

func _ready():
	var square = Square.new()
	square.size = size
	square.color = GameColor.TOWER
	square.border_color = GameColor.BORDER
	add_child(square)

	var range_on_hover = CircleRange.new()
	add_child(range_on_hover)

	var line = Line2D.new()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2(24.0, 0.0))
	line.default_color = GameColor.TOWER_RIFLE
	line.width = 6.0
	add_child(line)

	range_on_hover.enemy_in_range.connect(func(pos: Vector2):
		line.clear_points()	
		line.add_point(Vector2.ZERO)
		var angle = get_angle_to(pos)
		line.add_point(Vector2(24.0, 0.0).rotated(angle))
	)
