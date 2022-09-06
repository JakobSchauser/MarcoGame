extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func start_level(level):
	print(level)
	get_tree().change_scene(level)
	# add_child(i)
	# TODO transistion
