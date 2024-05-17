extends Node
class_name MapGenerator

enum Part {
	STRAIGHT = 0,
	LEFT = 69,
	RIGHT = 70,
} 

static func generate_map(
	road_len = 30
) -> PackedVector2Array:
	var road_parts = [Part.STRAIGHT, Part.LEFT, Part.RIGHT]
	var road_direction = Vector2(1, 0)
	var current_position = Vector2(0, 0)
	var path = PackedVector2Array()

	for i in road_len:
		var random_roll = randi_range(0, 100)

		# get random part
		var random_part = road_parts.pick_random()
		while random_roll < random_part:
			random_part = road_parts.pick_random()

		# update current position
		current_position += road_direction
		path.push_back(current_position)

		# update the direction
		match random_part:
			Part.LEFT: road_direction = Vector2(-road_direction.y, road_direction.x)
			Part.RIGHT: road_direction = Vector2(road_direction.y, -road_direction.x)
			Part.STRAIGHT: pass
	
	return path