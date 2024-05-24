@tool
extends Node2D
class_name Tower

@export var radius := 128.0:
	set(value):
		radius = value
		if tower_range.shape is CircleShape2D:
			tower_range.shape.radius = radius

@export var damage := 3
@export var speed := 1.0
@export var bullet_factory: Callable = Bullet.new
@export var square_color := GameColor.TOWER:
	set(value):
		square_color = value
		square.color = square_color

var active = false
var reloading = false
var size = Vector2(32.0, 32.0)
var tower_range = TowerRange.new()
var square = Square.new()

func reset_state():
	radius = 128.0
	damage = 3
	speed = 1.0

func _ready():
	square.size = size
	square.color = square_color
	square.border_color = GameColor.BORDER
	add_child(square)

	var circle = Circle.new()
	circle.radius = 8.0
	circle.color = GameColor.TOWER_RIFLE
	add_child(circle)

	tower_range.shape = CircleShape2D.new()
	tower_range.shape.radius = radius
	add_child(tower_range)

	var line = Line2D.new()
	line.add_point(Vector2.ZERO)
	line.add_point(Vector2(24.0, 0.0))
	line.default_color = GameColor.TOWER_RIFLE
	line.width = 6.0
	add_child(line)

	tower_range.closest_target.connect(func(pos: Vector2):
		line.clear_points()	
		line.add_point(Vector2.ZERO)
		var angle = get_angle_to(pos)
		line.add_point(Vector2(24.0, 0.0).rotated(angle))

		if !active:
			return

		if !reloading:
			
			#var bullet = FreezingBullet.new()
			var bullet = bullet_factory.call()
			bullet.damage = damage
			bullet.position = position + Vector2(24.0, 0.0).rotated(angle)
			bullet.direction = Vector2(24.0, 0.0).rotated(angle)
			bullet.distance_left = radius - 24.0
			add_sibling(bullet)

			reloading = true

			var loadbar = LoadBar.new()
			loadbar.position = Vector2(0, 12.0)
			# TODO: that's the rate of fire
			loadbar.time = speed
			add_child(loadbar)
			await loadbar.finished
			loadbar.queue_free()

			reloading = false
	)

func rotate_left():
	pass

func rotate_right():
	pass
