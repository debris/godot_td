extends Node2D

@onready var map_layer = $Map
@onready var menu = $Map/Menu
@onready var camera_center = $Map/Camera2D/CameraCenter

func _ready():
	var level = preload("res://levels/1.tscn").instantiate()

	level.cancel_card.connect(menu.reset_cards)
	level.card_used.connect(menu.show_next_wave_button)
	level.life_lost.connect(menu._on__life_lost)
	level.wave_finished.connect(menu._on__wave_finished)

	menu.card_pressed.connect(level._on_menu_card_pressed)
	menu.remove.connect(level._on_menu_remove)
	menu.start_wave.connect(level._on_menu_start_wave)

	map_layer.add_child(level)
	camera_center.level = level
