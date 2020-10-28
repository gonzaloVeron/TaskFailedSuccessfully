extends Node

var music := load("res://Music/Beavis and Butt-head (GENESIS) Music - Stage Sewage (48kbit_Opus)-[AudioTrimmer.com].wav")
func _ready():
	$Music.stream = music


func play_music():
	$Music.set_volume_db(-10)
	$Music.play()


func _on_Music_finished():
	play_music()

