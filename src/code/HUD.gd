extends CanvasLayer

signal start_game

const GAME_OVER_DELAY : int =  2
var game_over_timer : Timer

func _ready():
	game_over_timer = Timer.new()
	add_child(game_over_timer)
	game_over_timer.connect("timeout", self, "show_start_menu")
	game_over_timer.one_shot = true

func show_game_over(msg):
	$MessageLabel.text = msg
	$MessageLabel.show()
	
	game_over_timer.start(GAME_OVER_DELAY)


func show_start_menu():
	$MessageLabel.text = "Bellaland"
	$MessageLabel.show()
	
	$StartButton.show()


func _on_StartButton_pressed():
	emit_signal("start_game")
	$MessageLabel.hide()
	$StartButton.hide()
