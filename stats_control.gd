extends Control
class_name StatsControl

@export var attack_speed: float:
	set(value):
		attack_speed = value


@export var damage: float
@export var description: String

var as_label = Label.new()
var dmg_label = Label.new()
var desc_label = Label.new()

func update_as_label():
	as_label.text = "ATTACK SPEED: " + str(attack_speed)

func update_dmg_label():
	dmg_label.text = "DAMAGE: " + str(damage)

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	var grid = GridContainer.new()
	grid.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grid.anchors_preset = PRESET_FULL_RECT
	grid.add_theme_constant_override("v_separation", 0)
	add_child(grid)

	as_label.add_theme_color_override("font_color", Color.BLACK)
	as_label.add_theme_font_size_override("font_size", 10)
	grid.add_child(as_label)

	dmg_label.add_theme_color_override("font_color", Color.BLACK)
	dmg_label.add_theme_font_size_override("font_size", 10)
	grid.add_child(dmg_label)

	desc_label.add_theme_color_override("font_color", Color.BLACK)
	desc_label.add_theme_font_size_override("font_size", 10)
	desc_label.text = description
	grid.add_child(desc_label)

	custom_minimum_size = Vector2(as_label.size.x, 30.0)

	update_as_label()
	update_dmg_label()
