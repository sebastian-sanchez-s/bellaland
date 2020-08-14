extends "res://src/code/BellaStates/global.gd"


func _enter(host : KinematicBody2D):
	host.animation.play("Jump")
	host.jump_sound.play()
	
	velocity.y -= jump_speed
	velocity = host.move_and_slide(velocity, floor_normal)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func _get_input_and_apply_move(host):
	var move_direction = Input.get_action_strength("Right_key") - Input.get_action_strength("Left_key")
	velocity.x = on_air_speed*move_direction
	host.move_and_slide(velocity, floor_normal)
	
	host.animation.flip_h = velocity.x < 0
	
	if Input.is_action_just_pressed("Down_key"):
		velocity.y += fall_speed
	
	velocity = host.move_and_slide(velocity, floor_normal)
	is_on_floor = host.is_on_floor()

func update(host : KinematicBody2D, delta):
	_apply_gravity(delta)
	_get_input_and_apply_move(host)
	_is_running()
	
	if is_on_floor:
		if velocity.x == 0:
			return 'Idle'
		elif is_running:
			return 'Run'
		else:
			return 'Walk'
	if velocity.y > 0:
		return 'Fall'
