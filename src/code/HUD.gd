extends CanvasLayer

signal start_game
signal end_game

onready var OutGame = $OutGame
onready var InGame  = $InGame

func _on_GameOver(msg : String):
	InGame._on_GameOver()
	OutGame.show_game_over(msg)

func _on_NewGame(lives : int):
	OutGame.show_start_menu()
	InGame._on_NewGame(lives)

func _on_StartGame():
	emit_signal("start_game")

func _on_ExitGame():
	emit_signal("end_game")
