extends "res://Character/On_Ground.gd"

export(float) var max_walk_speed = 450
export(float) var max_run_speed = 700
var gravity = 50000
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

	velocity = input_direction * max_walk_speed
	velocity.y += gravity * _delta
	
	velocity = owner.move_and_slide(velocity, Vector2(0, -1), 5, 2)

#func move(speed, direction): 
#	velocity = direction.normalized() * speed
#	owner.move_and_slide(velocity, Vector2(), 5, 2)
#	if owner.get_slide_count() == 0:
#		return
#	return owner.get_slide_collision(0)




