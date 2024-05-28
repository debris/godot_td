extends Label
class_name Countdown

signal finished

@export var time: float:
	set(value):
		time = value
		fired = false

@export var active = false:
	set(value):
		active = value
		visible = active

var fired = false

func _ready():
	update_text()

func update_text():
	text = str(int(time))

func _process(delta):
	if Pause.paused || !active:
		return

	time -= delta
	if time >= 0:
		update_text()
	elif !fired:
		print_debug("fired countdown")
		fired = true
		finished.emit()
