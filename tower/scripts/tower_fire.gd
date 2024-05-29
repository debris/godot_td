extends Node
class_name TowerFire

signal aim_at(enemy: Vector2)
signal fire()

@export var tower: Tower
@export var reloading: TowerReloading
@export var nearest_enemy: TowerNearestEnemy

func _process(_delta):
	if Pause.paused:
		return

	if !tower.active:
		return

	var enemy = nearest_enemy.get_nearest_enemy()
	if enemy == null:
		return

	aim_at.emit(enemy.global_position)

	if reloading.is_reloading():
		return

	reloading.reload()
	fire.emit()
