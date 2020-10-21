extends Label

signal timeOutRestart()

var time = 5.0

func _ready():
	time = 5.0

func _process(delta):
	time = max(1.0, time - delta)
	text = str(int(round(time)))

func _on_Timer_timeout():
	print("dos veces?")
	emit_signal("timeOutRestart")
	get_parent().queue_free()
