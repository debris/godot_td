@tool
extends Node
class_name TowerReloading

@export var tower: Tower

var reloading := false

func is_reloading():
	return reloading

func reload():
	assert(!reloading, "cannot reload when previous reloading is not finished")
	reloading = true
	var loadbar = LoadBar.new()
	loadbar.position = Vector2(0, 12.0)
	loadbar.time = tower.stats.speed
	tower.add_child(loadbar)
	await loadbar.finished
	loadbar.queue_free()
	reloading = false
