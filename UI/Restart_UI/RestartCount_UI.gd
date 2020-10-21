extends Label

signal timeOutRestart()

var time = 5.0

func _ready():
	time = 5.0

func _process(delta):
	time = max(0.0, time - delta)
	if(time < 1):
		print("dos veces?")
		emit_signal("timeOutRestart")
		get_parent().queue_free()
	text = str(int(round(time)))
	
