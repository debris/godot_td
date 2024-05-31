extends Node

@export var paused := false

func _input(event):
	if event.is_action_pressed("pause"):
		paused = !paused
