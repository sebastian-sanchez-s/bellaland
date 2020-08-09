extends KinematicBody2D

signal player_dead(cause)


const BLINK_TIME : float = 0.2

var lives       : int = 3
var walk_speed  : int = 250
var jump_speed  : int = 500
var gravity     : int = 800

var screen_size : Vector2
var velocity    : Vector2


func _ready() -> void:
	screen_size = get_viewport_rect().size

func start_game() -> void:
	position = Vector2(100, 100)
	lives = 3
	show()

func _physics_process(delta):
	# HORIZONTAL DYNAMIC
	# movement
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x *= walk_speed
	# animation
	if is_on_floor():
		if velocity.x != 0:
			$AnimatedSprite.play("Walk")
		else:
			$AnimatedSprite.play("Idle")

	
	# VERTICAL DYNAMIC
	if not is_on_floor():
		velocity.y += gravity*delta
	
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y -= jump_speed
			$AnimatedSprite.play("Jump")
			$JumpEffect.play()
	if Input.is_action_just_pressed("ui_down"):
		if not is_on_floor():
			velocity.y += jump_speed*0.5
	
	$AnimatedSprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("player_dead", "fall")

func play_death() -> void:
	$AnimatedSprite.play("Death")
	$DeathSound.play()

func _on_Bella_hitted() -> void:
	lives -= 1
	if lives == 0:
		play_death()
		emit_signal("player_dead", "hit")
	else:
		blink()

func blink() -> void:
	for _i in range(4):
		$AnimatedSprite.modulate.a = 0.5
		yield(get_tree().create_timer(BLINK_TIME), "timeout")
		$AnimatedSprite.modulate.a = 1

# Getters and Setters are for external calls
func get_lives() -> int:
	return lives
 
func get_walk_speed() -> int:
	return walk_speed

func get_jump_speed() -> int:
	return jump_speed

func get_gravity_force() -> int:
	return gravity 

func get_velocity() -> Vector2:
	return velocity

func set_velocity(new_velocity : Vector2) -> void:
	velocity = new_velocity

func set_position(new_position:Vector2) -> void:
	position = new_position

func get_position() -> Vector2:
	return position
