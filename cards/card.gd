@tool
extends Resource
class_name Card

@export var cost: Cost
@export var name: String

func tower_constructor() -> Callable:
	assert(false, "unimplemented")
	return func(): pass
