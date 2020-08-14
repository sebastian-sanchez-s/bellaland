extends Node

const gravity      : int     = 480
const jump_speed   : int     = 250
const fall_speed   : int     = 100
const on_air_speed : int     = 100
const walk_speed   : int     = 150
const run_speed    : int     = 250

onready var lives = 3
onready var velocity     : Vector2 = Vector2.ZERO
onready var is_on_floor  : bool    = false
onready var is_running   : bool    = false
onready var floor_normal : Vector2 = Vector2(0, -1)

func _is_running():
	if Input.is_action_just_pressed("Run_key"):
		is_running = not is_running

func _apply_gravity(delta):
	velocity.y += gravity*delta
