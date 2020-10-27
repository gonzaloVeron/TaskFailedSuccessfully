extends Node2D

export var time_shooting: = 0.0
export var time_cooldown: = 0.0
export var laser_size: = 0 
export var raycast_size := 3
onready var raycast2d := $RayCast2D
onready var line2d := $Line2D
onready var timer_cooldown := $TimerCooldown
onready var timer_shooting := $TimerShooting



export var speed:= 50000
var is_shooting = false

func _physics_process(delta):
	check_for_hits()
	if is_shooting and raycast2d.is_colliding():
		make_beam()
	
	
func shoot():
	is_shooting = true
	
		
		#aca se puede agregar efectos visuales como particulas o etc. 
	pass

func set_laser_raycast_width_size(aSize):
	$RayCast2D.scale.x = aSize
	$RayCast2D.scale.y = aSize

func make_beam():
	line2d.points[1] = transform.xform_inv(raycast2d.get_collision_point())

func check_for_hits():
	if raycast2d.is_colliding() and raycast2d.get_collider().is_in_group("player") and raycast2d.get_collider() != null and line2d.points[1] != line2d.points[0]:
		raycast2d.get_collider().die()

func _ready():
	line2d.width = laser_size
	line2d.points[0] = $BeamStart.position
	line2d.points[1] = $BeamStart.position
	shoot()
	timer_shooting.set_wait_time(time_shooting)
	timer_cooldown.set_wait_time(time_cooldown)
	#raycast2d.add_exception()
	timer_shooting.start()
	set_laser_raycast_width_size(raycast_size)
	pass 


func _on_TimerShooting_timeout():
	#line2d.set_process(false)
	#line2d.set_physics_process(false)
	line2d.points[1] = line2d.points[0]
	is_shooting = false
	timer_cooldown.start()
	pass # Replace with function body.


func _on_TimerCooldown_timeout():
	#line2d.set_process(true)
	#line2d.set_physics_process(true)
	shoot()
	timer_shooting.start()
	pass # Replace with function body.


func _on_TimerFirstShoot_timeout():
	shoot()
	pass # Replace with function body.
