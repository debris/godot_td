@tool
extends Node
class_name TowerRange

signal target_in_range(pos: Vector2)

@export var size := Vector2(32.0, 32.0)
@export var shape: Shape2D:
	set(value):
		shape = value
		range_shape.shape = shape
		visual_shape.shape = shape
		
@export var shape_position := Vector2.ZERO:
	set(value):
		shape_position = value
		range_shape.position = shape_position
		visual_shape.position = shape_position

var enemies = {}
var buffs = {}
var range_shape = CollisionShape2D.new()
var visual_shape = VisualShape.new()
var stats_control = null

func show():
	visual_shape.visible = true

func hide():
	visual_shape.visible = false

func _ready():
	var parent = get_parent()

	var body_area = Area2D.new()
	body_area.collision_layer = 0
	body_area.collision_mask = 0
	body_area.set_collision_layer_value(GameLayer.TOWER, true)
	body_area.set_collision_mask_value(GameLayer.BUFF, true)
	parent.add_child(body_area)

	var body_collision = CollisionShape2D.new()
	body_collision.shape = RectangleShape2D.new()
	body_collision.shape.size = size
	body_area.add_child(body_collision)

	var area = Area2D.new()
	area.collision_layer = 0
	area.collision_mask = 0
	area.set_collision_mask_value(GameLayer.ENEMY, true)
	parent.add_child(area)

	range_shape.shape = shape
	range_shape.position = shape_position
	area.add_child(range_shape)

	var color = GameColor.TOWER_RANGE
	color.a = 0.3

	visual_shape.color = color
	visual_shape.shape = shape
	visual_shape.position = shape_position
	visual_shape.visible = false
	parent.add_child(visual_shape)

	body_area.area_entered.connect(func(buff):
		buffs[buff] = null	
		buff.add_buff_to(parent)
	)

	body_area.area_exited.connect(func(buff):
		buffs.erase(buff)
		parent.reset_state()
		for b in buffs:
			b.add_buff_to(parent)
	)

	area.area_entered.connect(func(body):
		enemies[body] = true
		print_debug("enemy in range")
	)

	area.area_exited.connect(func(body):
		print_debug("enemy exited")	
		enemies.erase(body)
	)

func _process(_delta):
	if Pause.paused:
		return

	var closest_distance = 0
	var closest_enemy = null
	for enemy in enemies:
		var distance = get_parent().global_position.distance_to(enemy.global_position)
		if closest_enemy == null || distance < closest_distance:
			closest_enemy = enemy
			closest_distance = distance

	if closest_enemy != null:
		target_in_range.emit(closest_enemy.global_position)
