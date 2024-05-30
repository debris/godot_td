@tool
extends Card
class_name CardTowerFreeze

func _init():
	cost = CostUnit.new(2)
	name = "Freezer"

func tower_constructor() -> Callable:
	return func():
		var tower = Tower.new()

		tower.bullet_factory = func():
			var bullet = Bullet.new()
			bullet.add_child(BulletModFreezing.new())
			return bullet

		tower.square_color = GameColor.TOWER_ALTERNATIVE
		return tower
