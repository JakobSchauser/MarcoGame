extends Node2D


var player_scene = load("res://Marco.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	G.set_game_state("tutorial")
	for i in range(len(G.players_data)):
		var d = G.players_data[i]
		var p = player_scene.instance()
		p.worm_name = d["name"]
		p.player_num = d["player_num"]
		p.color = d["color"]
		p.overworld = true
		if G.current_level_position == null:
			p.global_position = $StartPositions.get_child(i).global_position
			

		
		add_child(p)
		$Camera2D.add_target(p)
		$labels.get_child(i).show()

	
	$videoVideo.play()
