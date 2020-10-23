extends Node

func _on_Start_pressed():
	MusicController.play_music()
	get_tree().change_scene("res://Levels/Level_1/Level1.tscn")
