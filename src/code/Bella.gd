extends KinematicBody2D

signal fall

export var speed : int = 100
export var jump_speed : int = 1000
export var gravity : int = 500

var screen_size
var velocity : Vector2 = Vector2()


func _ready():
	screen_size = get_viewport_rect().size

func set_position(pos):
	position = pos

func get_position():
	return position

func _physics_process(delta):
	# Move left or right
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.x *= speed
	# Applying velocity
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_floor():
		if velocity.x == 0:
			$AnimatedSprite.play("Idle")
		else:
			$AnimatedSprite.play("Walk")
	# Gravity
	velocity.y += gravity * delta
	# Jump
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y -= jump_speed
		$AnimatedSprite.play("Jump")
	# Bella looks right or left depending of input
	$AnimatedSprite.flip_h = velocity.x < 0

func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("fall", "fall")

func game_over():
	velocity = Vector2.ZERO
	$AnimatedSprite.stop()
