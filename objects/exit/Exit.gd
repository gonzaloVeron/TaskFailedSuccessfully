extends Area2D

#var next_level_scene_path : String = ""
export var next_scene : PackedScene

onready var anim_player : AnimationPlayer = $AnimationPlayer

#func set_next_level_scene_path (scene_path):
#	next_level_scene_path = scene_path

func _ready():
	#$AnimationPlayer.play("default")
	anim_player.play("default")
	pass 

func teleport():
	anim_player.play("fade_in")
	yield(anim_player,"animation_finished")
	get_tree().change_scene_to(next_scene)

func _on_Exit_body_entered(body):
	if body.is_in_group("player"):
		teleport()
		#print("se deberia producir el cambio de nivel")
		#get_tree().change_scene(next_level_scene_path)
	
