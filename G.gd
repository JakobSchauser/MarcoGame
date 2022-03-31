extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var red = Color("FF3333")
var pink = Color("F15BB5")
var yellow = Color("FEE440")
var purple = Color("9B5DE5")
var blue = Color("00BBF9")
var green = Color("00F5D4")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func group(tag):
	return get_tree().get_nodes_in_group(tag)

func debug(x):
	print(x)
	return x