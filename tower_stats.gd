extends Resource
class_name TowerStats

@export var damage := 3.0
@export var speed := 1.0
@export var radius := 128.0:
	set(value):
		radius = value
		changed.emit()
