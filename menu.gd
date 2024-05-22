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

var extra_units := 0

@onready var card_grid = $CenterContainer/CardGrid
@onready var start_next_wave = $StartNextWave

func _ready():
	start_next_wave.visible = false

	for i in 3:
		var card_control = CardControl.new()
		card_control.card = all_cards.pick_random()
		card_grid.add_child(card_control)

		card_control.card_pressed.connect(func(card):
			card_pressed.emit(card)

			for cc in card_grid.get_children():
				cc.pull_down()
		)

func reset_cards():
	for cc in card_grid.get_children():
		cc.reset()

func show_next_wave_button():
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
	start_wave.emit(2 + extra_units)

func _on__wave_finished():
	reset_cards()
