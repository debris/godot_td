extends Node
class_name CameraMove

@export var speed: float = 256.0

func _process(delta):
	var parent = get_parent()
	if Input.is_action_pressed("ui_up"):
		print_debug("upppp")
		parent.position += Vector2.UP * delta * speed
	if Input.is_action_pressed("ui_down"):
		parent.position += Vector2.DOWN * delta * speed
	if Input.is_action_pressed("ui_left"):
		parent.position += Vector2.LEFT * delta * speed
	if Input.is_action_pressed("ui_right"):
		parent.position += Vector2.RIGHT * delta * speed

	if Input.is_action_pressed("zoom_out"):
		parent.zoom = parent.zoom.move_toward(Vector2(0.5, 0.5), delta)

	if Input.is_action_pressed("zoom_in"):
		parent.zoom = parent.zoom.move_toward(Vector2(2.0, 2.0), delta)
