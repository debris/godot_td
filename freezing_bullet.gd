extends Bullet
class_name FreezingBullet

func _ready():
	super._ready()

	area.area_entered.connect(func(body):
		var unit = body.get_parent()
		unit.add_child(Freeze.new())
	)
