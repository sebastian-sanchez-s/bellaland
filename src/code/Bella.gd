extends KinematicBody2D

signal player_fall
signal player_hit
signal player_killed


const BLINK_TIME : float = 0.2

var lives		: int = 3
var walk_speed	: int = 250
var jump_speed	: int = 500
var gravity		: int = 800

var screen_size	: Vector2
var velocity	: Vector2


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
	if Input.is_action_just_pressed("ui_down"):
		if not is_on_floor():
			velocity.y += jump_speed*0.5
	
	$AnimatedSprite.flip_h = velocity.x < 0
	
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("player_fall")

func game_over(cause_of_death : String) -> void:
	$AnimatedSprite.play("Death")

func lose_lives() -> void:
	lives -= 1

func is_dead() -> bool:
	if lives == 0:
		emit_signal("player_killed")
		return true
	return false

func blink() -> void:
	for i in range(4):
		$AnimatedSprite.modulate.a = 0.5
		yield(get_tree().create_timer(BLINK_TIME), "timeout")
		$AnimatedSprite.modulate.a = 1

# Getters and Setters are for external calls
func get_lives() -> int:
	return lives

func set_lives(lives) -> void:
	self.lives = lives
 
func get_walk_speed() -> int:
	return walk_speed

func get_jump_speed() -> int:
	return jump_speed

func get_gravity_force() -> int:
	return gravity 

func get_velocity() -> Vector2:
	return velocity

func set_velocity(velocity : Vector2) -> void:
	self.velocity = velocity

func set_position(position:Vector2) -> void:
	self.position = position

func get_position() -> Vector2:
	return position
