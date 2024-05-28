@tool
extends Node
class_name TowerBuffs

var buffs = {}

func _ready():
	var tower = get_parent()

	var body_area = Area2D.new()
	body_area.collision_layer = 0
	body_area.collision_mask = 0
	body_area.set_collision_layer_value(GameLayer.TOWER, true)
	body_area.set_collision_mask_value(GameLayer.BUFF, true)
	tower.add_child(body_area)

	var body_collision = CollisionShape2D.new()
	body_collision.shape = RectangleShape2D.new()
	body_collision.shape.size = Vector2(32.0, 32.0)
	body_area.add_child(body_collision)

	body_area.area_entered.connect(func(buff):
		buffs[buff] = null	
		buff.add_buff_to(tower)
	)

	body_area.area_exited.connect(func(buff):
		buffs.erase(buff)
		tower.reset_state()
		for b in buffs:
			b.add_buff_to(tower)
	)
