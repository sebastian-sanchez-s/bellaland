extends Node

signal start
signal exit

const GAME_OVER_DELAY : int =  2

onready var GameOverSound = $GameOver
onready var AcceptSound   = $Accept
onready var Title         = $Title
onready var Menu          = $Menu

onready var game_over_timer = Timer.new()

onready var over_color : Color = Color(138, 3, 3)    # blood like
onready var start_color: Color = Color(255, 0, 174)  # Bright pink


func _ready():
	add_child(game_over_timer)
	if  game_over_timer.connect("timeout", self, "show_start_menu"):
		print("Couldn't connect game_over_timer")
	game_over_timer.one_shot = true

func show_game_over(msg):
	GameOverSound.play()
	Title.add_color_override("font_color", over_color)
	Title.text = msg
	Title.show()
	game_over_timer.start(GAME_OVER_DELAY)

func show_start_menu():
	Title.add_color_override("font_color", start_color)
	Title.text = "Bellaland"
	Title.show()
	Menu.show()

func _on_StartBtn_pressed():
	emit_signal("start")
	AcceptSound.play()
	Title.hide()
	Menu.hide()

func _on_SettingsBtn_pressed():
	pass

func _on_ExitBtn_pressed():
	emit_signal("exit")
