extends Node

@export var level: Level:
	set(value):
		level = value
		instant_recenter()

func _ready():
	instant_recenter()

func instant_recenter():
	if level == null:
		return

	var parent = get_parent()
	parent.position = level.get_center()
	parent.zoom = Vector2.ONE

func recenter():
	var parent = get_parent()
	var tween = create_tween()
	tween.tween_property(parent, "position", level.get_center(), 0.2)
	tween.parallel().tween_property(parent, "zoom", Vector2.ONE, 0.2)
