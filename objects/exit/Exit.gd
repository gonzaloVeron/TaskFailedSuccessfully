extends Area2D

var next_level_scene_path : String = ""


func set_next_level_scene_path (scene_path):
	next_level_scene_path = scene_path

func _ready():
	$AnimationPlayer.play("default")
	pass 


func _on_Exit_body_entered(body):
	if body.is_in_group("player"):
		print("se deberia producir el cambio de nivel")
		#get_tree().change_scene(next_level_scene_path)
	
