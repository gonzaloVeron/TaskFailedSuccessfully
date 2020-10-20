extends KinematicBody2D
# The Player is a KinematicBody2D, in other words a physics-driven object.
# It can move, collide with the world, etc...
# The player has a state machine, but the body and the state machine are separate.

onready var raycast2d:= $RayCast2DLighting
onready var aim:= $Line2DAim
onready var body:= $BodyPivot
var default_aim_color = null

signal direction_changed(new_direction)

var look_direction = Vector2.RIGHT setget set_look_direction

func _ready():
	$Character_State_Machine/Jump.coll = $CollisionShape2D
	$Character_State_Machine/Move.coll = $CollisionShape2D
	default_aim_color = aim.get_default_color()
	
	

func _process(delta):
	
	raycast2d.global_position = body.get_global_position()
	aim.points[0] = body.position
	#if raycast2d.is_colliding():
	#	aim.points[1] = raycast2d.get_collision_point()
	#else:
#		aim.points[1] = get_global_mouse_position()


#line2d.points[1] = transform.xform_inv(raycast2d.get_collision_point())
func _physics_process(delta):
	if raycast2d.is_colliding():
		aim.set_point_position(1, transform.xform_inv(raycast2d.get_collision_point()))
		if raycast2d.get_collider().is_in_group("hook"):
			aim.set_default_color(ColorN("darkturquoise",1))
		else:
			aim.set_default_color(default_aim_color)
		
func take_damage(attacker, amount, effect = null):
	if is_a_parent_of(attacker):
		return
	$States/Stagger.knockback_direction = (attacker.global_position - global_position).normalized()
	$Health.take_damage(amount, effect)

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionPolygon2D.disabled = value

func set_look_direction(value):
	look_direction = value
	emit_signal("direction_changed", value)

func shoot_lighting():
	# velocity = (target - position).normalized() * speed
	
	#animacion aca (?
	if raycast2d.is_colliding() and raycast2d.get_collider().is_in_group("hook"): 
		var attraction_speed = (raycast2d.get_collider().position - body.position).normalized()
		var attraction_speed2 = (raycast2d.get_collider().get_global_position() - body.get_global_position()).normalized()
		
		print("gancho:")
		print(raycast2d.get_collider().position)
		## implementacion feeeeea.
		self.move_and_slide(attraction_speed2 * 15000)
		
		print("personaje:")
		print(body.position)
	pass
	
#func apply_movement(acceleration):
#   var movement = Vector2.ZERO
#	movement += acceleration
#	movement = movement.clamped(max_speed)
			
#func do_dash(delta):
#	dashing = true
#	var normalized_direction = (get_global_mouse_position() - position).normalized()
#	if (position.distance_to(get_global_mouse_position())> 10): 
#		apply_movement(normalized_direction * acceleration * delta) 
#		movement = move_and_slide(movement * 3)
