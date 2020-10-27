extends "res://Character/Motion.gd"

var speed:float
var velocity:Vector2
var direction:Vector2

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

func initialize(direction, speed, velocity):
	self.direction = direction
	horizontal_speed = speed
	max_horizontal_speed = speed if speed > 0.0 else base_max_horizontal_speed
	enter_velocity = velocity

# Clean up the state. Reinitialize values like a timer.
func exit():
	pass

func handle_input(_event):
	pass

func enter():
	horizontal_velocity = enter_velocity
	vertical_speed = 800.0

func update(delta):
	
	if owner.is_on_wall():
		emit_signal("finished", "idle")

	var input_direction = get_input_direction()

	move_horizontally(delta, self.direction)
	jump_height(delta)

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
