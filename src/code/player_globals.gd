extends Node

# idk
var lives = 3

# Physics
const gravity    : int     = 480
var velocity     : Vector2 = Vector2.ZERO
var jump_speed   : int     = 250
var fall_speed   : int     = jump_speed*0.5
var on_air_speed : int     = 90
var walk_speed   : int     = 100
var is_on_floor  : bool    = false
var floor_normal : Vector2 = Vector2(0, -1)

func _apply_gravity(delta):
	velocity.y += gravity*delta

# Graphics
const BLINK_TIME : int = 2

