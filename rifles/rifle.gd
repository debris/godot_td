@tool
extends Node2D
class_name Rifle

signal bullet_fired(bullet: Bullet)

func range_shape(_radius: float) -> Shape2D:
	assert(false, "unimplemented")
	return null

func range_position(_radius: float) -> Vector2:
	return Vector2.ZERO
	
func target_in_range(_target: Vector2):
	pass

func fire(_bullet_factory: Callable):
	assert(false, "unimplemented")
	pass
