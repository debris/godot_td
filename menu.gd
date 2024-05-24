extends CanvasLayer

signal recenter
signal remove
signal card_pressed(card: Card)
# todo: should be wave data instead of units
signal start_wave(units: int)

var all_cards = [
	CardTower.new(),
	CardTowerT2.new(),
	CardTowerFreeze.new()
]

@onready var card_grid = $CenterContainer/CardGrid
@onready var wave_label: Label = $Wave
@onready var choose_one_label: Label = $ChooseOneLabel
@onready var right_click_label: Label = $RightClickLabel
@onready var next_wave_units: CostControl = $NextWaveUnits
@onready var countdown: Countdown = $Countdown
@onready var health_label: Label = $HealthLabel

var wave := 1:
	set(value):
		wave = value
		if is_node_ready():
			update_wave_label()

var extra_units := 0
var pending_cost: Cost

var health := 10:
	set(value):
		health = value
		if is_node_ready():
			update_health_label()

func update_health_label():
	health_label.text = "HEALTH: " + str(health) + "/10"

func _ready():
	draw_cards()
	update_health_label()

	countdown.time = 5.0
	countdown.finished.connect(func():
		_on_start_next_wave_pressed()
	)

func draw_cards():
	countdown.active = false
	choose_one_label.visible = true
	right_click_label.visible = false

	for cc in card_grid.get_children():
		cc.queue_free()

	for i in 3:
		var card_control = CardControl.new()
		card_control.card = all_cards.pick_random()
		card_grid.add_child(card_control)

		card_control.card_pressed.connect(func(card):
			pending_cost = card.cost
			card_pressed.emit(card)
			choose_one_label.visible = false
			right_click_label.visible = true

			for cc in card_grid.get_children():
				cc.pull_down()
		)
	
	update_wave_label()

func update_wave_label():
	wave_label.text = "WAVE " + str(wave) + "/10"
	next_wave_units.cost = CostUnit.new(wave + extra_units)

func reset_cards():
	countdown.active = false
	choose_one_label.visible = true
	right_click_label.visible = false
	for cc in card_grid.get_children():
		cc.reset()

func show_next_wave_button():
	# apply cost
	if pending_cost is CostUnit:
		extra_units += pending_cost.value

	countdown.active = true
	countdown.time = 5.0
	right_click_label.visible = false
	next_wave_units.cost = CostUnit.new(wave + extra_units)

func _on_recenter_pressed():
	recenter.emit()

func _on_remove_pressed():
	remove.emit()

func _on_start_next_wave_pressed():
	countdown.active = false
	start_wave.emit(wave + extra_units)

func _on__wave_finished():
	wave += 1
	draw_cards()

func _on__life_lost():
	health -= 1
