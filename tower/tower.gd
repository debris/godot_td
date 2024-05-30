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
		square.border_color = square_color

var active = false
var reloading = false
var square = Square.new()
var nearest_enemy = TowerNearestEnemy.new()

func _ready():
	reset_state()

	square.size = Vector2(32.0, 32.0)
	square.color = square_color
	square.border_color = square_color
	add_child(square)

	# rifle expands beyond borders. make all rifles be visible above other tower squares
	rifle.z_index = 1
	add_child(rifle)

	var tower_reloading = TowerReloading.new()
	tower_reloading.tower = self
	add_child(tower_reloading)

	var mouse_hover = TowerMouseHover.new()
	mouse_hover.tower = self
	add_child(mouse_hover)

	var tower_range = TowerRange.new()
	tower_range.tower = self
	mouse_hover.mouse_entered.connect(tower_range.show_range)
	mouse_hover.mouse_exited.connect(tower_range.hide_range)
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
	tree_exiting.connect(stats_display.hide)
	stats_changed.connect(stats_display.refresh)
	add_child(stats_display)

	var tower_rotate = TowerRotate.new()
	tower_rotate.tower = self
	tower_rotate.tower_range = tower_range
	tower_rotate.mouse_hover = mouse_hover
	add_child(tower_rotate)

	var tower_buffs = TowerBuffs.new()
	add_child(tower_buffs)

	nearest_enemy.tower_range = tower_range
	add_child(nearest_enemy)

	var tower_fire = TowerFire.new()
	tower_fire.tower = self
	tower_fire.reloading = tower_reloading
	tower_fire.nearest_enemy = nearest_enemy
	add_child(tower_fire)

	tower_fire.aim_at.connect(func(enemy_position):
		rifle.look_at_target(enemy_position)
	)

	tower_fire.fire.connect(func():
		for fire_point in rifle.fire_points():
			var bullet = bullet_factory.call()
			bullet.global_position = fire_point.global_position
			bullet.global_rotation = fire_point.global_rotation
			bullet.damage = stats.damage
			bullet.distance_left = stats.radius - 24.0
			add_sibling(bullet)
	)
