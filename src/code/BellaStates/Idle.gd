extends "res://src/code/player_globals.gd"

func _enter(host : KinematicBody2D):
	velocity = Vector2.ZERO
	host.animation.play("Idle")
	
	_apply_gravity(1)
	velocity = host.move_and_slide(velocity)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func update(host : KinematicBody2D, delta):
	if Input.is_action_just_pressed("ui_up"):
		return 'Jump'
	if Input.is_action_just_pressed("ui_left") or Input.is_action_just_pressed("ui_right"):
		return 'Walk'
	
	_apply_gravity(delta)
	velocity = host.move_and_slide(velocity)


