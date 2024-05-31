extends Node2D
class_name Bullet

@export var damage := 3
@export var speed := 512.0
@export var distance_left := 100.0
@export var pierce = 0
@export var color := GameColor.BULLET:
	set(value):
		color = value
		queue_redraw()

var area = Area2D.new()

func _ready():
	area.collision_layer = 0
	area.collision_mask = 0
	area.set_collision_layer_value(GameLayer.BULLET, true)
	area.set_collision_mask_value(GameLayer.ENEMY, true)
	add_child(area)

	var range_shape = CollisionShape2D.new()
	range_shape.shape = CircleShape2D.new()
	# TODO: update if it changes with parent
	range_shape.shape.radius = 3
	area.add_child(range_shape)

	area.area_entered.connect(func(_body):
		if pierce == 0:
			queue_free()
		else:
			pierce -= 1
	)

func _process(delta):
	if Pause.paused:
		return

	position = position.move_toward(position + Vector2(distance_left, 0).rotated(global_rotation), speed * delta)
	distance_left -= speed * delta
	if distance_left <= 0.0:
		#speed = 0
		queue_free()

func _draw():
	draw_circle(Vector2.ZERO, 3, self.color)
