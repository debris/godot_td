@tool
extends Node2D
class_name Rifle

func range_shape(_radius: float) -> Shape2D:
	assert(false, "unimplemented")
	return null

func range_position(_radius: float) -> Vector2:
	return Vector2.ZERO
	
func look_at_target(_target: Vector2):
	pass

func fire_points() -> Array[Node2D]:
	assert(false, "unimplemented")
	return []
