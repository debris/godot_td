extends Control
class_name StatsControl

@export var attack_speed: float:
	set(value):
		attack_speed = value
		update_as_label()
		update_size()


@export var damage: float:
	set(value):
		damage = value
		update_dmg_label()

@export var description: String:
	set(value):
		description = value
		update_desc_label()
		update_size()

var as_label = Label.new()
var dmg_label = Label.new()
var desc_label = Label.new()

func update_as_label():
	as_label.text = "ATTACK SPEED: " + str(attack_speed)

func update_dmg_label():
	dmg_label.text = "DAMAGE: " + str(damage)

func update_desc_label():
	desc_label.text = description

func update_size():
	if description != null && description.length() > 0:
		custom_minimum_size = Vector2(as_label.size.x, 30.0)
	else:
		custom_minimum_size = Vector2(as_label.size.x, 20.0)

func _ready():
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	var grid = GridContainer.new()
	grid.mouse_filter = Control.MOUSE_FILTER_IGNORE
	grid.anchors_preset = PRESET_FULL_RECT
	grid.add_theme_constant_override("v_separation", 0)
	add_child(grid)

	as_label.add_theme_font_size_override("font_size", 10)
	update_as_label()
	grid.add_child(as_label)

	dmg_label.add_theme_font_size_override("font_size", 10)
	update_dmg_label()
	grid.add_child(dmg_label)

	desc_label.add_theme_font_size_override("font_size", 10)
	desc_label.text = description
	update_desc_label()
	grid.add_child(desc_label)

	update_size()
