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
var mouse_hover = MouseHover.new()
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

	mouse_hover.tower = self
	add_child(mouse_hover)

	mouse_hover.mouse_entered.connect(tower_range.show)
	mouse_hover.mouse_exited.connect(tower_range.hide)
	update_range_shape()
	add_child(tower_range)

	tower_range.target_in_range.connect(_on_target_in_range)

	var start_moving = StartMovingTower.new()
	start_moving.tower = self
	start_moving.level = get_parent()
	start_moving.mouse_hover = mouse_hover
	add_child(start_moving)

	var stats_display = StatsDisplay.new()
	stats_display.tower = self
	mouse_hover.mouse_entered.connect(stats_display.show)
	mouse_hover.mouse_exited.connect(stats_display.hide)
	add_child(stats_display)

	var tower_rotate = TowerRotate.new()
	tower_rotate.tower = self
	tower_rotate.mouse_hover = mouse_hover
	add_child(tower_rotate)

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
