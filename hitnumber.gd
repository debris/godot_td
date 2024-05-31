@tool
extends Node2D
class_name Hitnumber

@export var number: int:
	set(value):
		number = value
		update_text()

var speed = 32.0
var label = Label.new()

func _ready():
	label.theme = preload("res://game_theme.tres")
	label.add_theme_font_size_override("font_size", 10)
	update_text()
	add_child(label)

func update_text():
	label.text = str(number)

func _process(delta):
	if Pause.paused:
		return

	label.position.y -= delta * speed
	label.modulate.a -= delta

	if label.modulate.a <= 0.0:
		queue_free()
