extends "res://Character/On_Ground.gd"

export(float) var max_walk_speed = 450
export(float) var max_run_speed = 700
var gravity = 30000.0
var coll:CollisionShape2D

func enter():
	speed = 0.0
	velocity = Vector2()

	var input_direction = get_input_direction()

func handle_input(event):
	return .handle_input(event)

func update(_delta):
	var input_direction = get_input_direction()
	if not input_direction:
		emit_signal("finished", "idle")
	#if not owner.is_on_floor():
		#emit_signal("finished", "jump")
		#print(owner.is_on_floor())

	speed = max_walk_speed

	velocity = input_direction * speed
	velocity.y += gravity * _delta

	velocity = owner.move_and_slide(velocity, Vector2(0, -1), 5, 2)

func isOnFloor():
	return owner.is_on_floor()



