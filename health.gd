extends Resource
class_name Health

signal death

@export var current := 10:
	set(value):
		current = value
		changed.emit()
		if current <= 0:
			death.emit()
	
@export var maximum := 10:
	set(value):
		maximum = value
		changed.emit()

func percent() -> float:
	return float(current) / float(maximum)
