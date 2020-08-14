extends Node

onready var Global = get_parent()

func _enter(host : KinematicBody2D):
	host.animation.play("Walk")
	_get_input_and_apply_move(host)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func _get_input_and_apply_move(host):
	var move_direction = Input.get_action_strength("Right_key") - Input.get_action_strength("Left_key")
	Global.velocity.x = Global.walk_speed*move_direction
	Global.velocity = host.move_and_slide(Global.velocity, Global.floor_normal)
	
	host.animation.flip_h = Global.velocity.x < 0

func update(host : KinematicBody2D, delta):
	Global._apply_gravity(delta)
	_get_input_and_apply_move(host)
	Global._is_running()
	
	if Input.is_action_just_pressed("Jump_key"):
		return 'Jump'
	
	if Global.velocity.x == 0:
		return 'Idle'
	elif Global.is_running:
		return 'Run'
	
	if Global.velocity.y > 0:
		return 'Fall'
