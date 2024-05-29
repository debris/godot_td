extends Node
class_name BulletModFreezing

func _ready():
	get_parent().area.area_entered.connect(func(body):
		var unit = body.get_parent()
		unit.add_child(Freeze.new())
	)
