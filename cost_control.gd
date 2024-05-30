@tool
extends Control
class_name CostControl

@export var cost: Cost:
	set(value):
		cost = value
		update_icon()
		update_label()

var color_rect = ColorRect.new()
var cost_label := Label.new()
var cost_icon: Node2D = null

func update_icon():
	if cost_icon != null:
		cost_icon.queue_free()

	cost_icon = Unit.new()
	cost_icon.active = false
	cost_icon.position = size * Vector2(0.875, 0.5)
	resized.connect(func():
		cost_icon.position = size * Vector2(0.875, 0.5)
	)
	add_child(cost_icon)

func update_label():
	cost_label.text = "+" + str(cost.value)

func _ready():
	custom_minimum_size = Vector2(120.0, 32.0)
	size = custom_minimum_size
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	cost_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	cost_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	cost_label.add_theme_color_override("font_color", GameColor.TEXT)
	cost_label.size = Vector2(size.x - 24.0, 32.0)
	resized.connect(func():
		cost_label.size = Vector2(size.x - 24.0, 32.0)
	)
	add_child(cost_label)

	update_icon()
	update_label()
