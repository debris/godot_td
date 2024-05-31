@tool
extends Card
class_name CardTower

func _init():
	cost = CostUnit.new(1)

func tower_constructor() -> Callable:
	return func():
		var tower = Tower.new()
		tower.tower_name = "Dongle"
		return tower
