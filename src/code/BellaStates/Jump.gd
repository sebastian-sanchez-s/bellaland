extends "res://src/code/player_globals.gd"


func _enter(host : KinematicBody2D):
	velocity.y -= jump_speed
	host.animation.play("Jump")
	velocity = host.move_and_slide(velocity, floor_normal)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func _get_input_and_apply_move(host):
	var move_direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x = on_air_speed*move_direction
	host.move_and_slide(velocity, floor_normal)
	
	host.animation.flip_h = velocity.x < 0
	
	if Input.is_action_just_pressed("ui_down"):
		velocity.y += fall_speed
	
	velocity = host.move_and_slide(velocity, floor_normal)
	is_on_floor = host.is_on_floor()

func update(host : KinematicBody2D, delta):
	if is_on_floor:
		if velocity.x == 0:
			return 'Idle'
		else:
			return 'Walk'
	if velocity.y > 0:
		return 'Fall'
	
	_apply_gravity(delta)
	_get_input_and_apply_move(host)
