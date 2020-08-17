extends Node

onready var Global = get_parent()

signal player_killed

const BLINK_TIME : float = 1.0

onready var blink_timer = Timer.new()

var host_reference

func _ready():
	blink_timer.one_shot = true
	blink_timer.wait_time = BLINK_TIME
	add_child(blink_timer)
	if blink_timer.connect("timeout", self, "_stop_blink"):
			print("Coudn't connect blink_timer signal")

func _enter(host : KinematicBody2D):
	host.hit_sound.play()
	
	Global.lives -= 1
	
	if Global.lives == 0:
		emit_signal("player_killed")
	else:
		host_reference = host
		_start_blink(host)

func _start_blink(host):
	host.animation.self_modulate.a = 0.5
	blink_timer.start()

func _stop_blink():
	host_reference.animation.self_modulate.a = 1.0

func update(host : KinematicBody2D, _delta):
	# Go to previous state
	host._back()

func _exit(_host):
	pass
