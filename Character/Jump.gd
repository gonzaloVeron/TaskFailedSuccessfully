extends "res://Character/Motion.gd"

export(float) var base_max_horizontal_speed = 400.0

var coll:CollisionShape2D
export(float) var air_acceleration = 1000.0
export(float) var air_deceleration = 2000.0
export(float) var air_steering_power = 50.0

export(float) var gravity = 1600.0

var enter_velocity = Vector2()

var max_horizontal_speed = 0.0
var horizontal_speed = 0.0
var horizontal_velocity = Vector2()

var vertical_speed = 0.0
var height = 0.0

var velocity:Vector2

var animated

func initialize(speed, velocity):
	horizontal_speed = speed
	max_horizontal_speed = speed if speed > 0.0 else base_max_horizontal_speed
	enter_velocity = velocity

func enter():
	var input_direction = get_input_direction()

	horizontal_velocity = enter_velocity if input_direction else Vector2()
	vertical_speed = 600.0
	
	animated = get_parent().get_parent().get_node("BodyPivot/AnimatedSprite")

func update(delta):
	if owner.is_on_wall():
		emit_signal("finished", "idle")

	var input_direction = get_input_direction()

	move_horizontally(delta, input_direction)
	jump_height(delta)

	animated.play("jump")

func move_horizontally(delta, direction):
	if direction:
		horizontal_speed += air_acceleration * delta
	else:
		horizontal_speed -= air_deceleration * delta
	horizontal_speed = clamp(horizontal_speed, 0, max_horizontal_speed)

	var target_velocity = horizontal_speed * direction.normalized()
	var steering_velocity = (target_velocity - horizontal_velocity).normalized() * air_steering_power
	horizontal_velocity += steering_velocity

	owner.move_and_slide(horizontal_velocity)

func jump_height(delta):
	vertical_speed -= gravity * delta
	
	#parche para evitar que caiga rapido
	velocity = Vector2(0, min(500, vertical_speed * -1))
		
	owner.move_and_slide(velocity)
	
