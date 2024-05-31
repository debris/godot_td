@tool
extends Rifle
class_name RifleCircleSingle

var muzzle = Node2D.new()

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

	muzzle.position = Vector2(24.0, 0.0)
	line.add_child(muzzle)

func range_shape(radius: float) -> Shape2D:
	var shape = CircleShape2D.new()
	shape.radius = radius + 16.0
	return shape

func look_at_target(target: Vector2):
	look_at(target)

func fire_points() -> Array[Node2D]:
	return [muzzle]
	