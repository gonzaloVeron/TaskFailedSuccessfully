extends KinematicBody2D
# The Player is a KinematicBody2D, in other words a physics-driven object.
# It can move, collide with the world, etc...
# The player has a state machine, but the body and the state machine are separate.


onready var timer:=$LevelTimer
onready var raycast2d:= $RayCast2DLighting
onready var aim:= $Line2DAim
onready var body:= $BodyPivot
onready var csm:= $Character_State_Machine
onready var itimer:= $ImpulseTimer

var default_aim_color = null

signal direction_changed(new_direction)

signal die(pos)

var look_direction = Vector2.RIGHT setget set_look_direction

func _ready():
	
#	$Character_State_Machine/Jump.coll = $CollisionShape2D
#	$Character_State_Machine/Move.coll = $CollisionShape2D
	default_aim_color = aim.get_default_color()
	
func set_timer(seconds):
	timer.value = seconds

func _process(delta):
	
	raycast2d.global_position = body.get_global_position()
	aim.points[0] = body.position
	
func _physics_process(delta):
	if raycast2d.is_colliding():
		aim.set_point_position(1, transform.xform_inv(raycast2d.get_collision_point()))
		if raycast2d.get_collider().is_in_group("hook"):
			aim.set_default_color(ColorN("darkturquoise",1))
		#if raycast2d.get_collider().is_in_group("switch"):
		#	aim.set_default_color(ColorN("red",1))
		else:
			aim.set_default_color(default_aim_color)
		
#func take_damage(attacker, amount, effect = null):
#	if is_a_parent_of(attacker):
#		return
#	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
#	$Health.take_damage(amount, effect)

#func set_dead(value):
#	set_process_input(not value)
#	set_physics_process(not value)
#	$CollisionPolygon2D.disabled = value

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func shoot_lighting():
	#animacion aca (?
	if raycast2d.is_colliding() and raycast2d.get_collider().is_in_group("hook"): 
		var attraction_direction = (raycast2d.get_collider().get_global_position() - body.get_global_position()).normalized()
		var hookPosition = raycast2d.get_collider().get_global_position()
		csm.changeToLighting(attraction_direction, hookPosition)
	if raycast2d.is_colliding() and raycast2d.get_collider().is_in_group("switch"): 
		raycast2d.get_collider().activate()
	pass

func die():
	$Camera2D.clear_current()
	emit_signal("die", self.position)
	queue_free()

func _on_LevelTimer_timeOut():
	die()
