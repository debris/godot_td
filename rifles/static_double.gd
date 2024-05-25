@tool
extends Rifle
class_name RifleStaticDouble

func _ready():
	var line = Line2D.new()
	
	line.add_point(Vector2(0.0, -3.0))
	line.add_point(Vector2(24.0, -3.0))
	line.default_color = GameColor.TOWER_RIFLE
	line.width = 4.0
	add_child(line)

	var line2 = Line2D.new()
	line2.add_point(Vector2(0.0, 3.0))
	line2.add_point(Vector2(24.0, 3.0))
	line2.default_color = GameColor.TOWER_RIFLE
	line2.width = 4.0
	add_child(line2)
	
func range_shape(radius: float) -> Shape2D:
	var shape = RectangleShape2D.new()
	shape.size = Vector2(radius, 32.0)
	return shape

func range_position(radius: float) -> Vector2:
	return Vector2(radius / 2 + 16.0, 0.0)

func fire(bullet_factory: Callable):
	var bullet = bullet_factory.call()
	bullet.global_position = global_position + Vector2(24.0, -3.0).rotated(global_rotation)
	bullet.global_rotation = global_rotation
	bullet_fired.emit(bullet)

	var bullet2 = bullet_factory.call()
	bullet2.global_position = global_position + Vector2(24.0, 3.0).rotated(global_rotation)
	bullet2.global_rotation = global_rotation
	bullet_fired.emit(bullet2)
