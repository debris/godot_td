@tool
extends Node
class_name TempBuff

@export var time := 0.2

func _ready():
	apply_buff()

func _exit_tree():
	var parent = get_parent()

	# reset the modifiers on unit
	parent.reset()

	# reapply modifiers
	for child in parent.get_children():
		if child is TempBuff && child != self:
			child.apply_buff()

func apply_buff():
	assert(false, "unimplemented")

func _process(delta):
	if Pause.paused:
		return

	time -= delta

	if time < 0:
		queue_free()
