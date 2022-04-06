extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"



onready var players = get_parent().get_node("Players").get_children()

onready var face = preload("res://Face.tscn")
# onready var circle = preload("res://white_circle.tscn")

func _ready():
	for p in players:
		
		
		var l = Label.new()
		
		l.text = str(p.lives) + " - " + p.held_powerup + " "
		
		for w in G.worms:
			if w.name == p.worm_name:
				l.modulate = w.color
				break
				
				
				
		$CenterContainer/VBoxContainer/CharacterUI.add_child(l)
				

		
		
# # Called every frame. 'delta' is the elapsed time since the previous frame.
# func _process(delta):
# 	for p in players:
# 		pass
