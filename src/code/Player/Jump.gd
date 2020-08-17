extends Node

onready var Global = get_parent()

func _enter(host : KinematicBody2D):
	host.animation.play("Jump")
	host.jump_sound.play()
	
	Global.velocity.y -= Global.jump_speed
	Global.velocity = host.move_and_slide(Global.velocity, Global.floor_normal)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func _get_input_and_apply_move(host):
	var move_direction = Input.get_action_strength("Right_key") - Input.get_action_strength("Left_key")
	Global.velocity.x = Global.on_air_speed*move_direction
	host.move_and_slide(Global.velocity, Global.floor_normal)
	
	host.animation.flip_h = Global.velocity.x < 0
	
	if Input.is_action_just_pressed("Down_key"):
		Global.velocity.y += Global.fall_speed
	
	Global.velocity = host.move_and_slide(Global.velocity, Global.floor_normal)
	Global.is_on_floor = host.is_on_floor()

func update(host : KinematicBody2D, delta):
	Global._apply_gravity(delta)
	_get_input_and_apply_move(host)
	Global._is_running()
	
	if Global.is_on_floor:
		if Global.velocity.x == 0:
			return 'Idle'
		elif Global.is_running:
			return 'Run'
		else:
			return 'Walk'
	if Global.velocity.y > 0:
		return 'Fall'
