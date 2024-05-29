@tool
extends Node
class_name TowerRotate

@export var tower: Tower
@export var tower_range: TowerRange
@export var mouse_hover: TowerMouseHover

func _input(event):
	if !mouse_hover.is_hovered():
		return

	if event.is_action_pressed("rotate_left"):
		rotate_left()
	
	if event.is_action_pressed("rotate_right"):
		rotate_right()

func rotate_left():
	var rot = deg_to_rad(-90.0)
	tower.rifle.rotate(rot)
	tower_range.rotate(rot)

func rotate_right():
	var rot = deg_to_rad(90.0)
	tower.rifle.rotate(rot)
	tower_range.rotate(rot)
