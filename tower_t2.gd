@tool
extends Node2D
class_name TowerT2

@export var radius := 256.0:
	set(value):
		radius = value
		if tower_range.shape is RectangleShape2D:
			tower_range.shape.size = Vector2(radius, 32.0)
		tower_range.shape_position = Vector2(radius / 2 + 16.0, 0.0)

@export var damage := 3
@export var speed := 2.0

var active = false
var reloading = false

var size = Vector2(32.0, 32.0)

var line = Line2D.new()
var line2 = Line2D.new()
var tower_range = TowerRange.new()

func reset_state():
	radius = 256.0
	damage = 3
	speed = 2.0

func _ready():
	var square = Square.new()
	square.size = size
	square.color = GameColor.TOWER
	square.border_color = GameColor.BORDER
	add_child(square)

	line.add_point(Vector2(0.0, -3.0))
	line.add_point(Vector2(24.0, -3.0))
	line.default_color = GameColor.TOWER_RIFLE
	line.width = 4.0
	add_child(line)

	line2.add_point(Vector2(0.0, 3.0))
	line2.add_point(Vector2(24.0, 3.0))
	line2.default_color = GameColor.TOWER_RIFLE
	line2.width = 4.0
	add_child(line2)

	tower_range.shape = RectangleShape2D.new()
	tower_range.shape.size = Vector2(radius, 32.0)
	tower_range.shape_position = Vector2(radius / 2 + 16.0, 0.0)
	add_child(tower_range)

	tower_range.closest_target.connect(_fire_at)

func rotate_left():
	var rot = deg_to_rad(-90.0)
	rotate(rot)

func rotate_right():
	var rot = deg_to_rad(90.0)
	rotate(rot)

func _fire_at(_pos: Vector2):
	if !active:
		return

	if !reloading:
		var bullet = Bullet.new()
		bullet.damage = damage
		bullet.position = position + Vector2(24.0, -3.0).rotated(rotation)
		bullet.direction = Vector2(24.0, 0).rotated(rotation)
		bullet.distance_left = radius - 24.0
		add_sibling(bullet)

		var bullet2 = Bullet.new()
		bullet2.damage = damage
		bullet2.position = position + Vector2(24.0, 3.0).rotated(rotation)
		bullet2.direction = Vector2(24.0, 0).rotated(rotation)
		bullet2.distance_left = radius - 24.0
		add_sibling(bullet2)
		
		reloading = true

		var loadbar = LoadBar.new()
		loadbar.position = Vector2(0, 12.0)
		# TODO: that's the rate of fire
		loadbar.time = speed
		add_child(loadbar)
		await loadbar.finished
		loadbar.queue_free()

		reloading = false
