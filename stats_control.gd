extends Control
class_name StatsControl

@export var attack_speed: float
@export var damage: int
@export var description: String

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE
	var grid = GridContainer.new()
	grid.size = size - Vector2(32.0, 0.0)
	grid.anchors_preset = PRESET_FULL_RECT
	grid.add_theme_constant_override("v_separation", 0)
	add_child(grid)

	var as_label = Label.new()
	as_label.add_theme_color_override("font_color", Color.BLACK)
	as_label.add_theme_font_size_override("font_size", 10)
	as_label.text = "ATTACK SPEED: " + str(attack_speed)
	grid.add_child(as_label)

	var dmg_label = Label.new()
	dmg_label.add_theme_color_override("font_color", Color.BLACK)
	dmg_label.add_theme_font_size_override("font_size", 10)
	dmg_label.text = "DAMAGE: " + str(damage)
	grid.add_child(dmg_label)

	var desc_label = Label.new()
	desc_label.add_theme_color_override("font_color", Color.BLACK)
	desc_label.add_theme_font_size_override("font_size", 10)
	desc_label.text = description
	grid.add_child(desc_label)
