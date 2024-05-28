@tool
extends Node
class_name StatsDisplay

@export var tower: Tower

var stats_control = null

func show():
	if stats_control != null:
		stats_control.queue_free()

	stats_control = StatsControl.new()
	stats_control.attack_speed = tower.stats.speed
	stats_control.damage = tower.stats.damage
	TooltipLayer.add_tooltip(stats_control)

func hide():
	if stats_control != null:
		stats_control.queue_free()
		stats_control = null

func refresh():
	if stats_control != null:
		stats_control.attack_speed = tower.stats.speed
		stats_control.damage = tower.stats.damage
