extends Node2D

export (PackedScene) var enemy_scn
onready var alien_timer			: Timer = Timer.new()
onready var last_cause_death	: String

func _ready():
	$Bella.hide()
	
	alien_timer.set_wait_time(2)
	add_child(alien_timer)
	alien_timer.connect("timeout", self, "gen_aliens")
	
	$HUD.show_start_menu()

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()

func game_over(cause:String):
	alien_timer.stop()
	
	$Bella.game_over()
	
	$Music.stop()
	
	if cause == "fall":
		$HUD.show_game_over("Oh no! \nHas caído!")
	elif cause == "hit":
		$HUD.show_game_over("Te han \nAbducido!")
	
	last_cause_death = cause

func new_game():
	$Music.play()
	
	$Bella.set_position(Vector2(50, 100))
	$Bella.show()
	
	alien_timer.start()


func gen_aliens():
	var alien = enemy_scn.instance()
	
	alien.offset = $Bella.get_position()
	
	add_child(alien)
	alien.connect("hit", self, "game_over", ["hit"])
	
	if not $HUD.connect("start_game", alien, "free_aliens"):
		print("Couldn't connect to alien")
	
	alien_timer.start()
