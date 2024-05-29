@tool
extends Node2D
class_name TowerRange

@export var tower: Tower
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
var range_shape = CollisionShape2D.new()
var visual_shape = VisualShape.new()

func show_range():
	visual_shape.visible = true

func hide_range():
	visual_shape.visible = false

func update():
	shape = tower.rifle.range_shape(tower.stats.radius)
	shape_position = tower.rifle.range_position(tower.stats.radius)

func get_enemies():
	return enemies.keys()

func _ready():
	update()

	var area = Area2D.new()
	area.collision_layer = 0
	area.collision_mask = 0
	area.set_collision_mask_value(GameLayer.ENEMY, true)
	add_child(area)

	range_shape.shape = shape
	range_shape.position = shape_position
	area.add_child(range_shape)

	var color = GameColor.TOWER_RANGE
	color.a = 0.3

	visual_shape.color = color
	visual_shape.shape = shape
	visual_shape.position = shape_position
	visual_shape.visible = false
	add_child(visual_shape)

	area.area_entered.connect(func(body):
		enemies[body] = true
	)

	area.area_exited.connect(func(body):
		enemies.erase(body)
	)
