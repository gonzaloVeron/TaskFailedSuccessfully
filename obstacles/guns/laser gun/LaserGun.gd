extends Node2D

onready var raycast2d := $RayCast2D
onready var line2d := $Line2D


export var speed:= 50000

func _physics_process(delta):
	shoot()
	
func shoot():
	if raycast2d.is_colliding():
		make_beam()
		check_for_hits()
		#aca se puede agregar efectos visuales como particulas o etc. 
	pass

func make_beam():
	line2d.points[1] = transform.xform_inv(raycast2d.get_collision_point())

func check_for_hits():
	if raycast2d.get_collider().is_in_group("player"):
		raycast2d.get_collider().die()

func _ready():
	line2d.points[0] = $BeamStart.position
	pass 
