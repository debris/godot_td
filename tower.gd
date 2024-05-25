@tool
extends Node2D
class_name Tower

# stats are base stats multiplied by buffs
# TODO: support changing base stats after the tower in placed on the map
@export var base_stats := TowerStats.new()
@export var stats: TowerStats = TowerStats.new():
	set(value):
		stats = value
		stats.changed.connect(update_range_shape)
		update_range_shape()

func reset_state():
	stats = base_stats.duplicate()

@export var rifle: Rifle = RifleCircleSingle.new():
	set(value):
		rifle = value
		update_range_shape()

@export var bullet_factory: Callable = Bullet.new
@export var square_color := GameColor.TOWER:
	set(value):
		square_color = value
		square.color = square_color

var active = false
var reloading = false
var tower_range = TowerRange.new()
var square = Square.new()

func update_range_shape():
	tower_range.shape = rifle.range_shape(stats.radius)
	tower_range.shape_position = rifle.range_position(stats.radius)

func _ready():
	reset_state()
	square.size = Vector2(32.0, 32.0)
	square.color = square_color
	square.border_color = GameColor.BORDER
	add_child(square)

	rifle.bullet_fired.connect(func(bullet):
		bullet.damage = stats.damage
		bullet.distance_left = stats.radius - 24.0
		add_sibling(bullet)
	)
	add_child(rifle)

	update_range_shape()
	add_child(tower_range)

	tower_range.target_in_range.connect(_on_target_in_range)

func _on_target_in_range(target: Vector2):
	if !active:
		return

	rifle.target_in_range(target)

	if !reloading:
		rifle.fire(bullet_factory)	
		reloading = true

		var loadbar = LoadBar.new()
		loadbar.position = Vector2(0, 12.0)
		loadbar.time = stats.speed
		add_child(loadbar)
		await loadbar.finished
		loadbar.queue_free()

		reloading = false

func rotate_left():
	var rot = deg_to_rad(-90.0)
	rotate(rot)

func rotate_right():
	var rot = deg_to_rad(90.0)
	rotate(rot)
