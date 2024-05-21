@tool
extends Buff
class_name BuffDamage

@export var multiplier := 2:
	set(value):
		multiplier = value
		update_tooltip_text()
		
var display_square_tooltip = DisplaySquareTooltip.new()

func _ready():
	super._ready()
	update_tooltip_text()
	add_child(display_square_tooltip)

func update_tooltip_text():
	display_square_tooltip.text = "DAMAGE * " + str(multiplier)

func add_buff_to(tower: Node2D):
	if "damage" in tower:
		tower.damage *= multiplier
