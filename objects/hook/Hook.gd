extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func glow_on():
	$Light2D.set_process(true)
	$Light2D.visible = true
	
func glow_off():
	$Light2D.visible = false
	$Light2D.set_process(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Hook_area_entered(area):
	#aca se produciria el efecto
	pass # Replace with function body.
