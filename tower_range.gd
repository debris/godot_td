@tool
extends Node
class_name TowerRange

signal closest_target(pos: Vector2)

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
var hovered = false
var range_shape = CollisionShape2D.new()
var visual_shape = VisualShape.new()

func _ready():
	var parent = get_parent()

	var static_body = StaticBody2D.new()
	static_body.input_pickable = true
	static_body.collision_layer = 1
	static_body.collision_mask = 1
	parent.add_child(static_body)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = size
	static_body.add_child(collision_shape)

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

	static_body.mouse_entered.connect(func():
		visual_shape.visible = true
		hovered = true
	)

	static_body.mouse_exited.connect(func():
		visual_shape.visible = false
		hovered = false
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
	if hovered:
		if Input.is_action_just_pressed("rotate_left"):
			get_parent().rotate_left()

		if Input.is_action_just_pressed("rotate_right"):
			get_parent().rotate_right()

		if Input.is_action_just_pressed("left_click"):
			var move_tower = MoveTower.new()
			move_tower.level = get_parent().get_parent()
			move_tower.tower = get_parent()
			get_parent().add_sibling(move_tower)

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
		closest_target.emit(closest_enemy.global_position)
