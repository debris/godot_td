@tool
extends Control
class_name CardControl

signal card_pressed(card: Card)

@export var card: Card:
	set(value):
		card = value
		update_tower()
		update_cost()
		update_stats()
		update_name_label()

var color_rect = FramedRect.new()
var tower: Node2D = null
var cost_control: CostControl
var name_label := Label.new()
var stats_control = StatsControl.new()
var hovered = false
var pressed = false

func update_tower():
	if tower != null:
		tower.queue_free()
	tower = card.tower_constructor().call()
	tower.position = Vector2(10.0, 10.0) + Vector2(32.0, 32.0) / 2.0
	#tower.position = size * Vector2(0.25, 0.15)
	#resized.connect(func():
	#	tower.position = size * Vector2(0.25, 0.15)
	#)
	color_rect.add_child(tower)

func update_cost():
	if cost_control != null:
		cost_control.queue_free()
	cost_control = CostControl.new()
	cost_control.cost = card.cost
	cost_control.visible = false
	cost_control.position = Vector2(0.0, 0.0)
	color_rect.add_child(cost_control)

func update_stats():
	stats_control.attack_speed = tower.stats.speed
	stats_control.damage = tower.stats.damage
	stats_control.description = ""

func update_name_label():
	name_label.text = card.name

func _ready():
	custom_minimum_size = Vector2(120.0, 180.0)
	size = custom_minimum_size

	color_rect.pivot_offset = size / 2
	color_rect.size = size
	color_rect.anchors_preset = PRESET_FULL_RECT
	add_child(color_rect)

	var inner_rect = FramedRect.new()
	inner_rect.size = Vector2(120.0, 20.0 + 32.0)
	inner_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	inner_rect.color = GameColor.SLOT
	color_rect.add_child(inner_rect)

	name_label.position = Vector2(10.0, 62.0)
	name_label.add_theme_font_size_override("font_size", 10)
	color_rect.add_child(name_label)

	stats_control.position = Vector2(10.0, 82.0)
	color_rect.add_child(stats_control)

	update_tower()
	update_cost()
	update_stats()
	update_name_label()

	color_rect.mouse_entered.connect(func():
		hovered = true
		if !pressed:
			var tween = create_tween()
			tween.tween_property(color_rect, "position", Vector2(0.0, -100.0), 0.1)
			# (width + margins) / width
			var target_scale = 1.4 / 1.2
			tween.parallel().tween_property(color_rect, "scale", Vector2(target_scale, target_scale), 0.1)
	)

	color_rect.mouse_exited.connect(func():
		hovered = false
		if !pressed:
			var tween = create_tween()
			tween.tween_property(color_rect, "position", Vector2.ZERO, 0.1)
			tween.parallel().tween_property(color_rect, "scale", Vector2.ONE, 0.1)
	)			

func _input(event):
	if hovered && !pressed && event.is_action_pressed("left_click"):
		pressed = true

		card_pressed.emit(card)

func pull_down():
	var tween = create_tween()
	tween.tween_property(color_rect, "position", Vector2(0.0, 88.0), 0.1)
	tween.parallel().tween_property(color_rect, "scale", Vector2.ONE, 0.1)

func reset():
	hovered = false
	pressed = false
	var tween = create_tween()
	tween.tween_property(color_rect, "position", Vector2.ZERO, 0.1)
	tween.parallel().tween_property(color_rect, "scale", Vector2.ONE, 0.1)
