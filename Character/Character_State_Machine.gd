extends "res://Character/State_Machine.gd"

func _ready():
	owner = get_parent()
	states_map = {
		"idle": $Idle,
		"move": $Move,
		"jump": $Jump,
		"lighting": $Lighting
	}
	
	for state in states_map.values():
		state.owner = owner

func _change_state(state_name):
	print(state_name)
	# The base state_machine interface this node extends does most of the work.
	if not _active:
		return
	#if state_name in ["stagger", "jump", "attack"]:
	if state_name == "jump":
		states_stack.push_front(states_map[state_name])
	if state_name == "jump" and current_state == $Move:
		$Jump.initialize($Move.speed, $Move.velocity)
	._change_state(state_name)


func _unhandled_input(event):
	# Here we only handle input that can interrupt states, attacking in this case,
	# otherwise we let the state node handle it.
#	if event.is_action_pressed("attack"):
#		if current_state in [$Attack, $Stagger]:
#			return
#		_change_state("attack")
#		return
	## el lighting deberia interrumpir estados
	if Input.is_action_just_pressed("lighting"):
		current_state.owner.shoot_lighting()
	current_state.handle_input(event)

func changeToLighting(attraction_direction):
	$Lighting.initialize(attraction_direction, $Move.speed, $Move.velocity)
	._change_state("lighting")
