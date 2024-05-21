@tool
extends Buff
class_name BuffRange

@export var multiplier := 1.25:
	set(value):
		multiplier = value
		update_tooltip_text()
		
func add_buff_to(tower: Node2D):
	if "radius" in tower:
		tower.radius *= multiplier

func tooltip_text() -> String:
	return "RANGE * " + str(multiplier)