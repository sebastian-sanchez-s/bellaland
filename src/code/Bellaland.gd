extends Node2D

export (PackedScene) var enemy_scn
onready var alien_timer			: Timer = Timer.new()
onready var last_cause_death	: String

func _ready():
	$Bella.connect("player_fall", self, "game_over", ["fall"])
	$Bella.connect("player_hit", self, "game_over", ["hit"])
	$Bella.hide()
	
	alien_timer.set_wait_time(2)
	add_child(alien_timer)
	alien_timer.connect("timeout", self, "gen_aliens")
	
	$HUD.show_start_menu()

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		get_tree().quit()

func game_over(cause_of_death : String):
	alien_timer.stop()
	$Bella.game_over(cause_of_death)
	$Music.stop()
	if cause_of_death == "fall":
		$HUD.show_game_over("Oh no! \nHas caído!")
	elif cause_of_death == "hit":
		$HUD.show_game_over("Te han \nAbducido!")
	
	last_cause_death = cause_of_death

func new_game():
	$Music.play()
	$Bella.start_game()
	alien_timer.start()

func _on_alien_hit():
	$Bella.lose_lives()
	if $Bella.is_dead():
		$Bella.emit_signal("player_hit")
	else:
		$Bella.blink()

func gen_aliens():
	var alien = enemy_scn.instance()
	
	alien.offset = $Bella.get_position()
	
	add_child(alien)
	
	alien.connect("hit", self, "_on_alien_hit")
	alien.connect("hit", alien, "free_alien")
	$HUD.connect("start_game", alien, "_on_new_game")
	$Bella.connect("player_killed", alien, "_on_player_death")
	
	alien_timer.start()
