@tool
extends Card
class_name CardTowerT2

func _init():
	cost = CostUnit.new(1)

func tower_constructor() -> Callable:
	return TowerT2.new
