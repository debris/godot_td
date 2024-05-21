@tool
extends Buff
class_name BuffRange

func add_buff_to(tower: Node2D):
	if "radius" in tower:
		tower.radius *= 1.25
