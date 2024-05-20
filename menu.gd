extends CanvasLayer

signal start
signal recenter
signal add_tower
signal add_tower2
signal remove

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
