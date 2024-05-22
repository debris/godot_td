extends CanvasLayer

signal start
signal recenter
signal add_tower
signal add_tower2
signal remove
signal card_pressed(card: Card)
# todo: should be wave data instead of units
signal start_wave(units: int)

var all_cards = [
	CardTower.new(),
	CardTowerT2.new()
]

var wave := 1:
	set(value):
		wave = value
		if is_node_ready():
			update_wave_label()

@onready var card_grid = $CenterContainer/CardGrid
@onready var start_next_wave = $StartNextWave
@onready var wave_label = $Wave

var extra_units := 0
var pending_cost: Cost

func _ready():
	start_next_wave.visible = false

	for i in 3:
		var card_control = CardControl.new()
		card_control.card = all_cards.pick_random()
		card_grid.add_child(card_control)

		card_control.card_pressed.connect(func(card):
			pending_cost = card.cost
			card_pressed.emit(card)

			for cc in card_grid.get_children():
				cc.pull_down()
		)
	
	update_wave_label()

func update_wave_label():
	wave_label.text = "wave: " + str(wave) + "/20"

func reset_cards():
	for cc in card_grid.get_children():
		cc.reset()

func show_next_wave_button():
	# apply cost
	if pending_cost is CostUnit:
		extra_units += pending_cost.value

	start_next_wave.visible = true

func _on_start_pressed():
	start.emit()

func _on_recenter_pressed():
	recenter.emit()

func _on_tower_pressed():
	add_tower.emit()

func _on_tower_2_pressed():
	add_tower2.emit()

func _on_remove_pressed():
	remove.emit()

func _on_start_next_wave_pressed():
	start_next_wave.visible = false
	start_wave.emit(wave + extra_units)

func _on__wave_finished():
	wave += 1
	reset_cards()
