@tool
extends Area2D
class_name Buff

var display_square_tooltip = DisplaySquareTooltip.new()

func _ready():
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(GameLayer.BUFF, true)
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(8, 8)
	add_child(collision_shape)

	add_child(display_square_tooltip)
	update_tooltip_text()

func update_tooltip_text():
	display_square_tooltip.text = tooltip_text()

func add_buff_to(_tower: Tower):
	assert(false, "buff unimplemented")

func tooltip_text() -> String:
	assert(false, "tooltip text unimplemented")
	return ""
