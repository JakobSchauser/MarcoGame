extends Area2D
# Force hole by janking into other snake
# Slalom
# Destroy all snake bodies

var types = ["Lives","Slow others","Reversed controls","Boost","Stun"]
onready var type = types[randi() % types.size()]


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("area_entered",self,"on_area_entered")

func give_power(player):
	match type:
		"Lives": 
			player.lives += 2
		"Slow others":
			for p in get_tree().get_nodes_in_group("Player"):
				if p != player:
					p.power_slow()
		"Reversed controls":
			for p in get_tree().get_nodes_in_group("Player"):
				if p != player:
					p.power_reverse()
		"Boost":
			player.power_boost()
		"Stun":
			for p in get_tree().get_nodes_in_group("Player"):
				if p != player:
					p.power_stun()
	
	player.show_pickup("Picked up: " + type + "!")

func on_area_entered(area):
	if area.is_in_group("Player"):
		give_power(area)
		
		queue_free()
