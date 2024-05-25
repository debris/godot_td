@tool
extends Node2D
class_name Tower

@export var damage := 3
@export var speed := 1.0
@export var radius := 128.0:
	set(value):
		radius = value
		udpate_range_shape()

@export var rifle: Rifle = RifleCircleSingle.new():
	set(value):
		rifle = value
		udpate_range_shape()

@export var bullet_factory: Callable = Bullet.new
@export var square_color := GameColor.TOWER:
	set(value):
		square_color = value
		square.color = square_color

var active = false
var reloading = false
var tower_range = TowerRange.new()
var square = Square.new()

func udpate_range_shape():
	tower_range.shape = rifle.range_shape(radius)
	tower_range.shape_position = rifle.range_position(radius)

func reset_state():
	radius = 128.0
	damage = 3
	speed = 1.0

func _ready():
	square.size = Vector2(32.0, 32.0)
	square.color = square_color
	square.border_color = GameColor.BORDER
	add_child(square)

	rifle.bullet_fired.connect(func(bullet):
		bullet.damage = damage
		bullet.distance_left = radius - 24.0
		add_sibling(bullet)
	)
	add_child(rifle)

	tower_range.shape = rifle.range_shape(radius)
	tower_range.shape_position = rifle.range_position(radius)
	add_child(tower_range)

	tower_range.closest_target.connect(func(pos: Vector2):
		if !active:
			return

		rifle.target_in_range(pos)

		if !reloading:
			rifle.fire(bullet_factory)	
			reloading = true

			var loadbar = LoadBar.new()
			loadbar.position = Vector2(0, 12.0)
			loadbar.time = speed
			add_child(loadbar)
			await loadbar.finished
			loadbar.queue_free()

			reloading = false
	)

func rotate_left():
	var rot = deg_to_rad(-90.0)
	rotate(rot)

func rotate_right():
	var rot = deg_to_rad(90.0)
	rotate(rot)
