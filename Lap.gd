extends Area2D


signal race_over
# signal update_lap_label

var total_laps = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered", self, "on_body_entered")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func on_body_entered(player):
	if not player.is_in_group("Player"):
		return

	var sgn = sign(player.move_dir().x) # Work only in levels with horizontal lap
	
	var max_laps = player.laps
	player.laps += sgn
	for p in get_tree().get_nodes_in_group("Player"):
		if p.laps > max_laps:
			max_laps = p.laps

	get_tree().get_nodes_in_group("LapLabel")[0].text = "Lap " + str(max_laps) + " of " + str(total_laps)
	
	# emit_signal("update_lap_label", max_laps)

	if max_laps == total_laps + 1:
		emit_signal("race_over") 



# func get_leader():
