@tool
extends Buff
class_name BuffSpeed

@export var multiplier := 0.8:
	set(value):
		multiplier = value
		update_tooltip_text()
		
func add_buff_to(tower: Tower):
	tower.stats.speed *= multiplier

func tooltip_text() -> String:
	return "SPEED * " + str(multiplier)
