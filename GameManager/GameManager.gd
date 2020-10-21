extends Node

onready var restart_UI_template = preload("res://UI/Restart_UI/Restart_UI.tscn")
onready var character_template = preload("res://Character/Character.tscn")

export var spawnPoint:Vector2

func _on_Character_die(cameraDir):
	var restart_UI:Node2D = restart_UI_template.instance()
	restart_UI.global_position = cameraDir
	restart_UI.get_child(3).connect("timeOutRestart", self, "_on_Restart_UI_timeOutRestart")
	get_parent().add_child(restart_UI)

func _on_Restart_UI_timeOutRestart():
	var character:KinematicBody2D = character_template.instance()
	character.global_position = spawnPoint
	character.connect("die", self, "_on_Character_die")
	get_parent().add_child(character)
