extends Node

onready var restart_UI_template = preload("res://UI/Restart_UI/Restart_UI.tscn")
onready var character_template = preload("res://Character/Character.tscn")

onready var spawnPoint = $SpawnPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Character_die(cameraDir):
	var restart_UI:Node2D = restart_UI_template.instance()
	restart_UI.global_position = cameraDir
	restart_UI.get_child(3).connect("timeOutRestart", self, "_on_Restart_UI_timeOutRestart")
	get_parent().add_child(restart_UI)

func _on_Restart_UI_timeOutRestart():
	var character:KinematicBody2D = character_template.instance()
	character.global_position = spawnPoint.global_position
	character.connect("die", self, "_on_Character_die")
	get_parent().add_child(character)
