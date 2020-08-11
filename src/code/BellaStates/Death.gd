extends "res://src/code/player_globals.gd"

signal player_dead

func _enter(host : KinematicBody2D):
	velocity = Vector2.ZERO
	host.animation.play("Death")
	
	emit_signal("player_dead") 
