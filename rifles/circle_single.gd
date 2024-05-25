@tool
extends Rifle
class_name RifleCircleSingle

func _ready():
	var circle = Circle.new()
	circle.radius = 8.0
	circle.color = GameColor.TOWER_RIFLE
	add_child(circle)

	var line = Line2D.new()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2(24.0, 0.0))
	line.default_color = GameColor.TOWER_RIFLE
	line.width = 6.0
	add_child(line)

func range_shape(radius: float) -> Shape2D:
	var shape = CircleShape2D.new()
	shape.radius = radius
	return shape

func target_in_range(target: Vector2):
	look_at(target)

func fire(bullet_factory: Callable):
	var bullet = bullet_factory.call()
	bullet.global_position = global_position + Vector2(24.0, 0.0).rotated(global_rotation)
	bullet.global_rotation = global_rotation
	bullet_fired.emit(bullet)
