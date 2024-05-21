@tool
extends Area2D
class_name Buff

func _ready():
	collision_layer = 0
	collision_mask = 0
	set_collision_layer_value(GameLayer.BUFF, true)
	
	var collision_shape = CollisionShape2D.new()
	collision_shape.shape = RectangleShape2D.new()
	collision_shape.shape.size = Vector2(8, 8)
	add_child(collision_shape)

func add_buff_to(_tower: Node2D):
	assert(false, "buff unimplemented")
