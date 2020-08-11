extends Node

# idk
var lives = 3

# Physics
const gravity    : int     = 480
var velocity     : Vector2 = Vector2.ZERO
var jump_speed   : int     = 250
var fall_speed   : int     = jump_speed*0.5
var on_air_speed : int     = 90
var walk_speed   : int     = 150
var run_speed    : int     = walk_speed*2
var is_on_floor  : bool    = false
var floor_normal : Vector2 = Vector2(0, -1)

func _apply_gravity(delta):
	velocity.y += gravity*delta


