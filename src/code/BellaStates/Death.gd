extends Node

onready var Global = get_parent()

signal player_dead

func _enter(host : KinematicBody2D):
	"""
	This State is called only by the hit signal not when it falls
	
	1. Left the player stuck on the place where has been killed
	2. Play the death animation and wait fot it to finish, once 
	   finished it stop (avoiding death loop animation)
	3. Tell the state machine that the player has been killed
	"""
	Global.velocity = Vector2.ZERO
	
	host.death_sound.play()
	host.animation.play("Death")
	yield(host.animation, "animation_finished")
	host.animation.stop()
	
	emit_signal("player_dead")

func _exit(_host : KinematicBody2D):
	pass

func update(_host : KinematicBody2D, _delta):
	pass
