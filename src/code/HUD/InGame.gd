extends Node

onready var LivesHolder = $LivesHolder
onready var HeartIc     = preload("res://res/UI/InGame/ic_lives.png")

func _ready():
	LivesHolder.hide()

func fill_LivesHolder(lives : int):
	"""
	Create as many heart icons as lives passed
	"""
	for heart in lives:
		var ic_heart = TextureRect.new()
		ic_heart.set_texture(HeartIc)
		LivesHolder.add_child(ic_heart)
	
	LivesHolder.show()

func clean_LivesHolder():
	for heart in LivesHolder.get_children():
		heart.queue_free()
	
	LivesHolder.hide()

func _on_PlayerHit():
	if LivesHolder.get_child_count():
		LivesHolder.get_child(0).queue_free()
