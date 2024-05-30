@tool
extends TempBuff
class_name Freeze

func apply_buff():
	get_parent().speed_modifier = 0.0
	get_parent().modulate = GameColor.FREEZE
