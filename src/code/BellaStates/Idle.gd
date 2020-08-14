extends "res://src/code/BellaStates/global.gd"

func _enter(host : KinematicBody2D):
	velocity = Vector2.ZERO
	host.animation.play("Idle")
	
	#_apply_gravity(1)
	#velocity = host.move_and_slide(velocity)

func _exit(host : KinematicBody2D):
	host.animation.stop()

func update(host : KinematicBody2D, delta):
	_apply_gravity(delta)
	velocity = host.move_and_slide(velocity)
	_is_running()
	
	if Input.is_action_just_pressed("Jump_key"):
		return 'Jump'
	if velocity.y > 0:
		return 'Fall'
	
	if Input.is_action_just_pressed("Right_key") or Input.is_action_just_pressed("Left_key"):
		if is_running:
			return 'Run'
		else:
			return 'Walk'



