extends CanvasLayer

signal start_game
signal end_game

onready var OutGame = $OutGame
onready var InGame  = $InGame

func game_over(msg : String):
	InGame.clean_LivesHolder()
	OutGame.show_game_over(msg)

func start_game(lives : int):
	InGame.fill_LivesHolder(lives)

func show_start_menu():
	InGame.clean_LivesHolder()
	OutGame.show_start_menu()

func _on_end_game():
	emit_signal("end_game")

func _on_start_game():
	emit_signal("start_game")
