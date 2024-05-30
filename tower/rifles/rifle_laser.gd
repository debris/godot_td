@tool
extends Rifle
class_name RifleLaser

var muzzle := Node2D.new()
var line := Line2D.new()
var timeleft := 0.0

func _ready():
	line.width = 4.0
	line.default_color = GameColor.BULLET
	add_child(line)

	var circle = Circle.new()
	circle.radius = 8.0
	circle.color = GameColor.TOWER_RIFLE
	add_child(circle)

	muzzle.position = Vector2(24.0, 0.0)
	add_child(muzzle)

func range_shape(radius: float) -> Shape2D:
	var shape = CircleShape2D.new()
	shape.radius = radius
	return shape

func look_at_target(target: Vector2):
	look_at(target)

	line.clear_points()
	line.add_point(Vector2.ZERO)
	line.add_point(to_local(target))

	timeleft = 0.1

func _process(delta):
	if timeleft > 0:
		timeleft -= delta
	else:
		line.clear_points()

func fire_points() -> Array[Node2D]:
	return [muzzle]
