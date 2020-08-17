extends KinematicBody2D

signal player_dead(cause)

onready var animation   = $Sprite
onready var jump_sound  = $JumpEffect
onready var hit_sound   = $Hit
onready var death_sound = $DeathSound

var curr_state_id = null
var prev_state_id = null

var states_id     = {}
var states_holder = {}


func _ready():
	add_state("Idle")
	add_state("Walk")
	add_state("Run")
	add_state("Jump")
	add_state("Fall")
	add_state("Hit")
	add_state("Death")
	# start on idle state
	curr_state_id = states_id["Idle"]
	# Death state is called by player_killed signal on hit state
	if states_holder[states_id["Hit"]].connect("player_killed", self, "_change_state", ["Death"]):
		print("Couldn't connect player_killed signal")
	if states_holder[states_id["Death"]].connect("player_dead", self, "_on_PlayerKilled"):
		print("Couldn't connect player_dead signal")

func add_state(state_name):
	var id = states_id.size()
	states_id[state_name] = id
	states_holder[id] = $States.get_node(state_name)
	
func _physics_process(delta):
	var state_name = states_holder[curr_state_id].update(self, delta)
	if state_name:
		$StateLabel.text = state_name
		_change_state(state_name)

func _change_state(new_state):
	var new_state_id = states_id[new_state]
	prev_state_id = curr_state_id
	curr_state_id = new_state_id
	if prev_state_id != null:
		states_holder[prev_state_id]._exit(self)
	if curr_state_id != null:
		states_holder[curr_state_id]._enter(self)

func _start():
	position = Vector2(100,100)
	$States.set_lives(3)
	_change_state("Idle")

func _back():
	curr_state_id = prev_state_id

func _on_VisibilityNotifier2d():
	_change_state("Death")

func _on_PlayerKilled():
	emit_signal("player_dead", "hit")

func _on_PlayerFall():
	emit_signal("player_dead", "fall")
