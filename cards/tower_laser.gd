@tool
extends Card
class_name CardLaser

func _init():
	cost = CostUnit.new(2)

func tower_constructor() -> Callable:
	return func():
		var tower = Tower.new()

		tower.rifle = RifleLaser.new()
		tower.base_stats.radius = 128.0
		tower.base_stats.speed = 0.2
		tower.base_stats.damage = 1.0

		tower.bullet_factory = func():
			var bullet = Bullet.new()
			bullet.speed = 1000.0
			bullet.add_child(BulletModInvisible.new())
			return bullet

		return tower