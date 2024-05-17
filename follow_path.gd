extends Node
class_name FollowPath

signal finished

@export var path: PackedVector2Array:
	set(value):
		path = value
		path_index = 0

@export var speed := 256.0

var path_index := 0

func _process(delta):
	if Pause.paused:
		return

	if path.size() > path_index:
		var parent = get_parent()
		var path_to_position = path[path_index] * Vector2(32.0, 32.0)
		parent.position = parent.position.move_toward(path_to_position, delta * speed)
		if parent.position.is_equal_approx(path_to_position):
			path_index += 1

			# check if we reached the end of the patH
			if path_index >= path.size():
				print_debug("follow_path::finished")
				finished.emit()
