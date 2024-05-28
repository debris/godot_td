@tool
extends Node2D
class_name Tower

signal stats_changed
signal rifle_changed

# stats are base stats multiplied by buffs
# TODO: support changing base stats after the tower in placed on the map
@export var base_stats := TowerStats.new()
@export var stats: TowerStats = TowerStats.new():
	set(value):
		stats = value
		stats.changed.connect(func():
			stats_changed.emit()
		)
		stats_changed.emit()

func reset_state():
	stats = base_stats.duplicate()

@export var rifle: Rifle = RifleCircleSingle.new():
	set(value):
		rifle = value
		rifle_changed.emit()

@export var bullet_factory: Callable = Bullet.new
@export var square_color := GameColor.TOWER:
	set(value):
		square_color = value
		square.color = square_color

var active = false
var reloading = false
var tower_range = TowerRange.new()
var square = Square.new()
var nearest_enemy = TowerNearestEnemy.new()

func _ready():
	var mouse_hover = TowerMouseHover.new()

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
	stats_changed.connect(tower_range.update)
	rifle_changed.connect(tower_range.update)
	add_child(tower_range)

	var move_start = TowerMoveStart.new()
	move_start.tower = self
	move_start.level = get_parent()
	move_start.mouse_hover = mouse_hover
	add_child(move_start)

	var stats_display = StatsDisplay.new()
	stats_display.tower = self
	mouse_hover.mouse_entered.connect(stats_display.show)
	mouse_hover.mouse_exited.connect(stats_display.hide)
	stats_changed.connect(stats_display.refresh)
	add_child(stats_display)

	var tower_rotate = TowerRotate.new()
	tower_rotate.tower = self
	tower_rotate.mouse_hover = mouse_hover
	add_child(tower_rotate)

	var tower_buffs = TowerBuffs.new()
	add_child(tower_buffs)

	nearest_enemy.tower_range = tower_range
	add_child(nearest_enemy)

func _process(_delta):
	if Pause.paused:
		return

	if !active:
		return

	var enemy = nearest_enemy.get_nearest_enemy()
	if enemy == null:
		return

	rifle.target_in_range(enemy.global_position)

	if !reloading:
		rifle.fire(bullet_factory)	
		reloading = true
		await display_loadbar()
		reloading = false

func display_loadbar():
	var loadbar = LoadBar.new()
	loadbar.position = Vector2(0, 12.0)
	loadbar.time = stats.speed
	add_child(loadbar)
	await loadbar.finished
	loadbar.queue_free()
