extends Node

onready var LivesHolder = $LivesHolder
onready var HeartIc     = preload("res://res/UI/InGame/ic_lives.png")

func _on_NewGame(lives : int):
	for _heart in lives:
		var ic_heart = TextureRect.new()
		ic_heart.set_texture(HeartIc)
		LivesHolder.add_child(ic_heart)

func _on_GameOver():
	pass

func _on_PlayerHit():
	if LivesHolder.get_child_count():
		LivesHolder.get_child(0).queue_free()
