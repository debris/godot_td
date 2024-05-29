@tool
extends Rifle
class_name RifleStaticDouble

var muzzles: Array[Node2D] = []

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

	var muzzle = Node2D.new()
	muzzle.position = Vector2(24.0, -3.0)
	line.add_child(muzzle)
	muzzles.push_back(muzzle)

	var muzzle2 = Node2D.new()
	muzzle2.position = Vector2(24.0, 3.0)
	line2.add_child(muzzle2)
	muzzles.push_back(muzzle2)
	
func range_shape(radius: float) -> Shape2D:
	var shape = RectangleShape2D.new()
	shape.size = Vector2(radius, 32.0)
	return shape

func range_position(radius: float) -> Vector2:
	return Vector2(radius / 2 + 16.0, 0.0)

func fire_points() -> Array[Node2D]:
	return muzzles
