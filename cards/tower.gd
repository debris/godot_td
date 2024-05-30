@tool
extends Card
class_name CardTower

func _init():
	cost = CostUnit.new(1)
	name = "Dongle"

func tower_constructor() -> Callable:
	return Tower.new
