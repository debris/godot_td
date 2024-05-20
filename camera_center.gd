extends Node

@export var level: Level

func _ready():
	recenter()

func recenter():
	get_parent().position = level.get_center()
