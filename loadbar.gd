extends Bar
class_name LoadBar

@export var time := 1.0

func _process(delta):
	if Pause.paused:
		return

	value += delta / time
