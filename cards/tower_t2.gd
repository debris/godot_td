@tool
extends Card
class_name CardTowerT2

func _init():
	cost = CostUnit.new(1)

func tower_constructor() -> Callable:
	return func():
		var tower = Tower.new()
		tower.tower_name = "Double Penetrator"
		tower.description = "piercing bullets"

		tower.rifle = RifleStaticDouble.new()
		tower.base_stats.radius = 256.0
		tower.base_stats.speed = 2.0

		tower.bullet_factory = func():
			var bullet = Bullet.new()
			bullet.pierce = 100
			return bullet
		
		return tower
