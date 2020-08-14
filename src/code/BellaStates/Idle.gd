extends Node

onready var Global = get_parent()

func _enter(host : KinematicBody2D):
	Global.velocity = Vector2.ZERO
	host.animation.play("Idle")

func _exit(host : KinematicBody2D):
	host.animation.stop()

func update(host : KinematicBody2D, delta):
	Global._apply_gravity(delta)
	Global.velocity = host.move_and_slide(Global.velocity)
	Global._is_running()
	
	if Input.is_action_just_pressed("Jump_key"):
		return 'Jump'
	if Global.velocity.y > 0:
		return 'Fall'
	
	if Input.is_action_just_pressed("Right_key") or Input.is_action_just_pressed("Left_key"):
		if Global.is_running:
			return 'Run'
		else:
			return 'Walk'



