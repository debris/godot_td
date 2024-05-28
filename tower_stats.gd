extends Resource
class_name TowerStats

@export var damage := 3.0:
	set(value):
		damage = value
		changed.emit()

@export var speed := 1.0:
	set(value):
		speed = value
		changed.emit()

@export var radius := 128.0:
	set(value):
		radius = value
		changed.emit()
