class_name Tooltip
extends Node2D

@export var text: String:
	set(value):
		text = value
		label.text = text

var label = Label.new()

func _ready():
	label.text = text
	add_child(label)
