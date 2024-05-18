extends Node2D
class_name Bullet

@export var direction := Vector2.ZERO
@export var speed := 128.0

func _ready():
	var area = DamageArea.new()
	area.damage = 3
	area.collision_layer = 0
	area.collision_mask = 0
	area.set_collision_layer_value(GameLayer.BULLET, true)
	area.set_collision_mask_value(GameLayer.ENEMY, true)
	add_child(area)

	var range_shape = CollisionShape2D.new()
	range_shape.shape = CircleShape2D.new()
	# TODO: update if it changes with parent
	range_shape.shape.radius = 2
	area.add_child(range_shape)

	area.area_entered.connect(func(_body):
		queue_free()
	)

func _process(delta):
	if Pause.paused:
		return
	
	position = position.move_toward(direction * Vector2(1000.0, 1000.0), speed * delta)

func _draw():
	draw_circle(Vector2.ZERO, 2, Color.RED)
