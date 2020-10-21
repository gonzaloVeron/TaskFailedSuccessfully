extends Node2D

signal timerChange(val)

var value = 60

func _ready():
	emit_signal("timerChange", value)

func _process(delta):
	value -= delta
	emit_signal("timerChange", _roundToInt(value))

# --------------------------------------------------- #

func increaseTimer(val):
	value += val
	emit_signal("timerChange", _roundToInt(value))

func _roundToInt(val):
	return int(round(val))

func setTimer(val):
	value = val
