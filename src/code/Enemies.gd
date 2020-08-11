extends KinematicBody2D

signal hit

export var min_speed = 300
export var max_speed = 400

var alien_anim = ["Swim", "Walk", "Fly"]
var velocity : Vector2
var offset : Vector2 = Vector2.ZERO

func _ready():
	position = Vector2(
			offset.x + 1000,
			rand_range(offset.y - 100, offset.y + 100))

	velocity = Vector2(
			-rand_range(min_speed, max_speed),
			0)
	
	$Sprite.animation  = alien_anim[randi() % alien_anim.size()]
	$Sprite.flip_h = true
	$Sprite.play()

func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision and collision.collider.name == "Bella":
		emit_signal("hit")

func _on_Bella_killed(_cause : String):
	$Sprite.stop()
	velocity = Vector2.ZERO

func free_alien():
	queue_free()
