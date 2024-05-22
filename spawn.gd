extends Node
class_name Spawn

signal spawn(unit: Unit)
signal finished

@export var limit := 0
@export var interval := 0.5

var time_since = 0.0

func _process(delta):
	if Pause.paused:
		return

	time_since += delta
	if time_since > interval:
		time_since -= interval

		if limit > 0:
			limit -= 1
			var unit = Unit.new()
			spawn.emit(unit)
		elif limit == 0:
			limit -= 1
			finished.emit()
