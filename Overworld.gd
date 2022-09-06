extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(len(G.players_data)):
		var d = G.players_data[i]
		var p = player_scene.instance()
		p.worm_name = d["name"]
		p.player_num = d["player_num"]
		p.color = d["color"]
		p.global_position = $StartPositions.get_child(i).global_position
		add_child(p)
		


func start_level(level):
	print(level)
	get_tree().change_scene(level)
	# add_child(i)
	# TODO transistion
