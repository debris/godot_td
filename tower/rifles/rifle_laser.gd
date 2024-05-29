@tool
extends Rifle
class_name RifleLaser

var muzzle = Node2D.new()
var line: Line2D
var timeleft := 0.0

func _ready():
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

	if line != null:
		line.queue_free()

	line = Line2D.new()
	line.width = 4.0
	line.default_color = Color.AQUAMARINE
	line.add_point(Vector2.ZERO)
	line.add_point(to_local(target))
	add_child(line)

	timeleft = 0.1

func _process(delta):
	if timeleft > 0:
		timeleft -= delta
	elif line != null:
		line.queue_free()
		line = null

func fire_points() -> Array[Node2D]:
	return [muzzle]
