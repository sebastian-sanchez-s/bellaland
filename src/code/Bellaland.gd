extends Node2D

export (PackedScene) var enemy_scn

onready var Player     = $Bella
onready var PlayerData = $Bella/States
onready var Music      = $Music
onready var HUD        = $HUD

onready var alien_timer : Timer = Timer.new()

const ALIEN_FREQ : int = 5

func _ready():
	if Player.connect("player_dead", self, "_on_Bella_death"):
		exit()
	
	alien_timer.set_wait_time(ALIEN_FREQ)
	add_child(alien_timer)
	if alien_timer.connect("timeout", self, "generate_alien"):
		exit()
	
	HUD.show_start_menu()

func _process(_delta):
	if Input.is_action_just_pressed("ui_end"):
		exit()

func exit():
	get_tree().quit()

func _on_Bella_death(cause_of_death : String):
	alien_timer.stop()
	Music.stop()
	Player.hide()
	if cause_of_death == "fall":
		HUD.game_over("Oh no! \nHas caido!")
	elif cause_of_death == "hit":
		HUD.game_over("Te han \nAbducido!")

func new_game():
	Music.play()
	Player._start()
	Player.show()
	alien_timer.start()
	HUD.start_game(PlayerData.get_lives())

func generate_alien():
	var alien = enemy_scn.instance()
	
	alien.offset = Player.get_position()
	
	add_child(alien)
	if alien.connect("hit", alien, "free_alien") or\
	alien.connect("hit", HUD.get_node("InGame"), "_on_PlayerHit") or\
	HUD.connect("start_game", alien, "free_alien") or\
	alien.connect("hit", Player, "_change_state", ["Hit"]) or\
	Player.connect("player_dead", alien, "_on_Bella_killed"):
		alien.free_alien()
	else:
		alien_timer.start()
