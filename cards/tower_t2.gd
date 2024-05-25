@tool
extends Card
class_name CardTowerT2

func _init():
	cost = CostUnit.new(1)

func tower_constructor() -> Callable:
	return func():
		var tower = Tower.new()
		tower.rifle = RifleStaticDouble.new()
		tower.base_stats.radius = 256.0
		tower.base_stats.speed = 2.0
		return tower
