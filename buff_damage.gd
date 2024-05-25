@tool
extends Buff
class_name BuffDamage

@export var multiplier := 2:
	set(value):
		multiplier = value
		update_tooltip_text()
		
func add_buff_to(tower: Tower):
	tower.stats.damage *= multiplier

func tooltip_text() -> String:
	return "DAMAGE * " + str(multiplier)
