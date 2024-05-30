extends CanvasLayer

var margin_container = MarginContainer.new()
var grid := GridContainer.new()

func _ready():

	var color_rect = FramedRect.new()
	#var color_rect = ColorRect.new()
	#color_rect.color = GameColor.BACKGROUND
	color_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(color_rect)
	
	grid.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grid.theme = preload("res://game_theme.tres")
	grid.item_rect_changed.connect(func():
		if !grid.size.is_zero_approx():
			color_rect.position = grid.position - Vector2(10.0, 10.0)
			color_rect.size = grid.size + Vector2(20.0, 20.0)
		else:
			color_rect.size = Vector2.ZERO
	)
	add_child(grid)

func add_tooltip(tooltip):
	grid.global_position = get_viewport().get_mouse_position() + Vector2(10.0, 10.0) + Vector2(16.0, 16.0)
	tooltip.tree_exited.connect(func():
		grid.size = grid.custom_minimum_size
	)
	grid.add_child(tooltip)

func _process(_delta):
	grid.global_position = get_viewport().get_mouse_position() + Vector2(10.0, 10.0) + Vector2(16.0, 16.0)
	