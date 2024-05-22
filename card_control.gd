@tool
extends Control
class_name CardControl

signal card_pressed(card: Card)

@export var card: Card:
	set(value):
		card = value
		update_tower()
		update_cost()

var color_rect = ColorRect.new()
var tower: Node2D = null
var cost_control: CostControl
var hovered = false
var pressed = false

func update_tower():
	if tower != null:
		tower.queue_free()
	tower = card.tower_constructor().call()
	tower.position = size * Vector2(0.25, 0.15)
	resized.connect(func():
		tower.position = size * Vector2(0.25, 0.15)
	)
	color_rect.add_child(tower)

func update_cost():
	if cost_control != null:
		cost_control.queue_free()
	cost_control = CostControl.new()
	cost_control.cost = card.cost
	cost_control.position = Vector2(0.0, 0.0)
	color_rect.add_child(cost_control)

func _ready():
	custom_minimum_size = Vector2(120.0, 180.0)
	size = custom_minimum_size

	color_rect.size = size
	color_rect.anchors_preset = PRESET_FULL_RECT
	add_child(color_rect)

	update_tower()
	update_cost()

	color_rect.mouse_entered.connect(func():
		hovered = true
		if !pressed:
			var tween = create_tween()
			tween.tween_property(color_rect, "position", Vector2(0.0, -120.0), 0.1)
	)

	color_rect.mouse_exited.connect(func():
		hovered = false
		if !pressed:
			var tween = create_tween()
			tween.tween_property(color_rect, "position", Vector2.ZERO, 0.1)
	)			

func _input(event):
	if hovered && !pressed && event.is_action_pressed("left_click"):
		pressed = true

		card_pressed.emit(card)

func pull_down():
	var tween = create_tween()
	tween.tween_property(color_rect, "position", Vector2(0.0, 60.0), 0.1)

func reset():
	hovered = false
	pressed = false
	var tween = create_tween()
	tween.tween_property(color_rect, "position", Vector2.ZERO, 0.1)
