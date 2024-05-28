@tool
extends Node
class_name StartMovingTower

@export var tower: Tower
@export var level: Level
@export var mouse_hover: MouseHover

func _input(event):
	if !mouse_hover.is_hovered():
		return

	if !tower.active:
		return

	if event.is_action_pressed("left_click"):
		var move_tower = MoveTower.new()
		move_tower.level = level
		move_tower.tower = tower
		tower.add_child(move_tower)
