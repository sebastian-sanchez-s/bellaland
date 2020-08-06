extends CanvasLayer

signal start_game


func show_game_over(msg):
	$MessageLabel.text = msg
	$MessageLabel.show()
	start_menu()


func start_menu():
	yield(get_tree().create_timer(2), "timeout")
	
	$MessageLabel.text = "Bellaland"
	$MessageLabel.show()
	
	yield(get_tree().create_timer(0.5), "timeout")
	
	$StartButton.show()


func _on_StartButton_pressed():
	emit_signal("start_game")
	$MessageLabel.hide()
	$StartButton.hide()
