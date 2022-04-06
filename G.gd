extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var red = Color("FF004D")
var pink = Color("FF77A8")
var yellow = Color("FFEC27")
var purple = Color("7E2553")
var blue = Color("29ADFF")
var turqoise = Color("FFCCAA")
var green = Color("00E436")
var brown = Color("AB5236")
var silver = Color("83769C")

var colors = {
	"red": red,
	"pink": pink,
	"yellow": yellow,
	"purple": purple,
	"blue": blue,
	"turqoise": turqoise,
	"green": green,
	"brown": brown,
	"silver": silver
}

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