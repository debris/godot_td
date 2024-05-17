extends Node

func position_to_index_i(value: float) -> int:
	# normalize, cause square is drawn from the center
	if value > 0:
		value += 16.0
	elif value < 0:
		value -= 16.0

	return int(value) / 32

func position_to_index(pos: Vector2) -> Vector2:
	return Vector2(position_to_index_i(pos.x), position_to_index_i(pos.y))

# normalized to always be a multiple of 32.0
func index_to_position(index: Vector2) -> Vector2:
	return index * Vector2(32.0, 32.0)
