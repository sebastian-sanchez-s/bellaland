extends "res://src/code/BellaStates/global.gd"

func _enter(host : KinematicBody2D):
	host.animation.play("Walk")
	_get_input_and_apply_move(host)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func _get_input_and_apply_move(host):
	var move_direction = Input.get_action_strength("Right_key") - Input.get_action_strength("Left_key")
	velocity.x = walk_speed*move_direction
	velocity = host.move_and_slide(velocity, floor_normal)
	
	host.animation.flip_h = velocity.x < 0

func update(host : KinematicBody2D, delta):
	_apply_gravity(delta)
	_get_input_and_apply_move(host)
	_is_running()
	
	if Input.is_action_just_pressed("Jump_key"):
		return 'Jump'
	
	if velocity.x == 0:
		return 'Idle'
	elif is_running:
		return 'Run'
	
	if velocity.y > 0:
		return 'Fall'
