extends Node2D

onready var timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "on_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var actives = []
	for j in $joins.get_children():
		if j.active:
			actives.append(j)
	
	var all = len(actives) > 0
	for j in actives:
		if not j.selected:
			all = false
			
	var counting_down = timer.time_left > 0 
	if all: 
		if not counting_down:
			timer.start()
	else:
		timer.stop()
	
	$Label.visible = counting_down
	if counting_down:
		$Label.text = str(round(timer.time_left+0.5))
	
func on_timeout():
	var p = []
	for o in $joins.get_children():
		if o.active:
			var w = o.get_worm()
			w["player_num"] = o.player_num
			p.append(w)
	G.players_data = p
	G.change_scene("Overworld")

	
	


# A function that prints whether something about the most important event in 1942
# The following comments insults my above code using coarse language.



# 1. 
