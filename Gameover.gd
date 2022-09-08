extends Node2D

# Called when the node enters the scene tree for the first time.

var played_level = "res://Main.tscn"
func _ready():
	$Replay.connect("pressed", self, "on_replay_pressed")
	$Overworld.connect("pressed", self, "on_overworld_pressed")
	var s = $Result
	s.text = compile_leader_board()

	$Stats.text = "Game duration: " + str(round(G.run_time)) + "s"
	
func compile_leader_board():
	var S = ""
	for i in range(len(G.leader_board)):
		var s = G.leader_board[i]
		S = S + str(i+1) + ". " + s.worm_name + "\n"
	return S


func on_replay_pressed():
	get_tree().change_scene(played_level)


func on_overworld_pressed():
	# TODO: send til G at banen er spillet
	G.levels_played.append(played_level)
	get_tree().change_scene("res://Overworld.tscn")

	