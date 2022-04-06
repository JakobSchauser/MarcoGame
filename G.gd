extends Node


# Stats to display
var run_time = 0
var winner = null
# var n_pickups = 

var leader_board = []



var red = Color("FF004D")
var pink = Color("FF77A8")
var yellow = Color("FFEC27")
var purple = Color("7E2553")
var blue = Color("29ADFF")
var darkblue = Color("2d10f4")
var turqoise = Color("FFCCAA")
var green = Color("00E436")
var darkgreen = Color("008751")
var brown = Color("AB5236")
var silver = Color("83769C")

var colors = {
	"red": red,
	"pink": pink,
	"yellow": yellow,
	"purple": purple,
	"blue": blue,
	"darkblue": darkblue,
	"turqoise": turqoise,
	"green": green,
	"darkgreen": darkgreen,
	"brown": brown,
	"silver": silver,
	"white": Color.white
}



var worms = [
	{ "name": "Agnes",
	   "describe": "Royal blue business ladylike.",
	   "color": colors.blue },

	{ "name": "Marco",
	   "describe": "The classic.",
	   "color": colors.green
    },
	{
		"name": "Levi",
		"color": colors.red,
		"describe": "Pants!"
	},
	{   "name": "Udo",
	    "color": colors.yellow,
		"describe": "Loves archives"
	}
	]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(dt):
	run_time += dt

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func timer(delay):
	return get_tree().create_timer(delay)

func group(tag):
	return get_tree().get_nodes_in_group(tag)

func debug(x):
	print(x)
	return x