@tool
extends Node
class_name TowerNearestEnemy

@export var tower_range: TowerRange

var cache = null

func get_nearest_enemy():
	if cache != null:
		return cache

	var nearest_distance = 0
	var nearest_enemy = null

	var enemies = tower_range.get_enemies()
	for enemy in enemies:
		var distance = get_parent().global_position.distance_to(enemy.global_position)
		if nearest_enemy == null || distance < nearest_distance:
			nearest_enemy = enemy
			nearest_distance = distance

	cache = nearest_enemy
	return nearest_enemy

func _process(_delta):
	cache = null
