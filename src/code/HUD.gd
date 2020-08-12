extends CanvasLayer

signal start_game
signal end_game

onready var OutGame = $OutGame
#onready var InGame  = $InGame

func _on_GameOver(msg : String):
	#InGame.hide()
	OutGame.show_game_over(msg)

func _on_NewGame():
	OutGame.show_start_menu()

func _on_StartGame():
	emit_signal("start_game")

func _on_ExitGame():
	emit_signal("end_game")
