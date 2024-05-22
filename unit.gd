@tool
extends Node2D
class_name Unit

const SPEED := 50.0

signal goal_reached

@export var active := true:
	set(value):
		active = value
		area.monitorable = active
		area.monitoring = active

@export var health := Health.new()
@export var target_position: Vector2:
	set(value):
		target_position = value
		navigation_agent.target_position = target_position

var navigation_agent = NavigationAgent2D.new()
var area = Area2D.new()

func _ready():
	navigation_agent.path_desired_distance = 8.0
	navigation_agent.navigation_finished.connect(func():
		goal_reached.emit()
	)
	add_child(navigation_agent)

	var size = Vector2(16.0, 16.0)

	var square = Square.new()
	square.size = size
	square.color = GameColor.ENEMY
	square.border_color = GameColor.BORDER
	add_child(square)

	var head = Square.new()
	head.size = Vector2(8.0, 6.0)
	head.position = Vector2(0.0, -8.0)
	head.color = GameColor.ENEMY
	head.border_color = GameColor.BORDER
	square.add_child(head)

	area.collision_layer = 0
	area.collision_mask = 0
	area.set_collision_layer_value(GameLayer.ENEMY, true)
	area.set_collision_mask_value(GameLayer.BULLET, true)
	add_child(area)

	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = size
	area.add_child(collision_shape)

	area.area_entered.connect(func(body):
		# hit by the bullet
		if body is DamageArea:
			health.current -= body.damage
	)

	health.death.connect(func():
		queue_free()
	)

	var bar = Bar.new()
	bar.position = Vector2(0.0, 12.0)
	bar.value = 0.0
	add_child(bar)

	health.changed.connect(func():
		bar.value = health.percent()
	)

func _process(delta):
	if Pause.paused || !active:
		return

	var next_position = navigation_agent.get_next_path_position()
	position = position.move_toward(next_position, delta * SPEED)
