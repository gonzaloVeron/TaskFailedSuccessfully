extends "res://Character/On_Ground.gd"

export(float) var gravity = 1600.0

func handle_input(event):
	return .handle_input(event)

func update(_delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	
	velocity.y += gravity * _delta
	velocity = owner.move_and_slide(velocity, Vector2(0, -1), 5, 2)

func isOnFloor():
	return owner.is_on_floor()
