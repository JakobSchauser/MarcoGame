extends Node


# Stats to display
var run_time = 0
var winner = null
# var n_pickups = 

var leader_board = []

var red = Color("FF5C5C")
var pink = Color("F47BC4")
var yellow = Color("FEEB71")
var purple = Color("B284EB")
var blue = Color("47D1FF")
var turqoise = Color("85FFEF")
var green = Color("62E95D")
var brown = Color("D0804E")
var silver = Color("A8A29F")

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

func timer(delay):
	get_tree().create_timer(delay)

func group(tag):
	return get_tree().get_nodes_in_group(tag)

func debug(x):
	print(x)
	return x