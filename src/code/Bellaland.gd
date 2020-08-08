extends Node2D

export (PackedScene) var enemy_scn
onready var alien_timer         : Timer = Timer.new()
onready var last_cause_death    : String

const ALIEN_FREQ : int = 2

func _ready():
	if $Bella.connect("player_dead", self, "_on_Bella_death"):
		exit()
	$Bella.hide()
	
	alien_timer.set_wait_time(ALIEN_FREQ)
	add_child(alien_timer)
	if alien_timer.connect("timeout", self, "generate_alien"):
		exit()
	
	$HUD.show_start_menu()

func _process(delta):
	if Input.is_action_just_pressed("ui_end"):
		exit()

func exit():
	get_tree().quit()

func _on_Bella_death(cause_of_death : String):
	alien_timer.stop()
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


func generate_alien():
	var alien = enemy_scn.instance()
	
	alien.offset = $Bella.get_position()
	
	add_child(alien)
	if alien.connect("hit", alien, "free_alien") or $HUD.connect("start_game", alien, "free_alien") or alien.connect("hit", $Bella, "_on_Bella_hitted") or $Bella.connect("player_dead", alien, "_on_Bella_killed"):
		alien.free_alien()
	else:
		alien_timer.start()
