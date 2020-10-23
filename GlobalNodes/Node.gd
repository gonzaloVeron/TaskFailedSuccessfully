extends Node

var music := load("res://Music/Beavis and Butt-head (GENESIS) Music - Stage Sewage (48kbit_Opus)-[AudioTrimmer.com].wav")
func _ready():
	$Music.stream = music
	pass # Replace with function body.

func play_music():
	$Music.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Music_finished():
	play_music()
	pass # Replace with function body.
