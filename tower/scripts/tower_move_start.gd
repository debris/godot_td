@tool
extends Node
class_name TowerMoveStart

@export var tower: Tower
@export var level: Level
@export var mouse_hover: TowerMouseHover

func _input(event):
	if !mouse_hover.is_hovered():
		return

	if !tower.active:
		return

	if event.is_action_pressed("left_click"):
		var move = TowerMove.new()
		move.level = level
		move.tower = tower
		tower.add_child(move)
