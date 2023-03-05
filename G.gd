extends Node


# Stats to display
var run_time = 0
var winner = null
# var n_pickups = 

var leader_board = []

var levels_played = []
var levels_locked = ["LakeVostok", "LakeEyre", "LakeBaikal", "LakeLadoga", "LakeTanga", "LakeTiticaca", ]

var red = Color("FF004D")
var pink = Color("FF77A8")
var yellow = Color("FFEC27")
var purple = Color("7E2553")
var blue = Color("4984b8")
var darkblue = Color("2d10f4")
var turqoise = Color("FFCCAA")
var green = Color("00E436")
var darkgreen = Color("008751")
var brown = Color("AB5236")
var silver = Color("FFFFFF")

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

var current_level_position = null

var GAMEMODE = 'story'

var worms = [
	{ "name": "Agnes",
		"player_num": 0,
	   "describe": "Royal blue business ladylike.",
	   "color": blue },
	   
	{ "name": "Marco",
	"player_num": 1,

	   "describe": "Ham kender vi.",
	   "color": darkgreen
	},
	{
		"name": "Levi",
	"player_num": 2,
		"color": red,
		"describe": "Vild og eventyrlysten."
	},
	{   "name": "Udo",
	"player_num": 3,
	"color": yellow,
	"describe": "Din standard måleorm."
}
]

var players_data = [worms[0], worms[1]]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(dt):
	run_time += dt

	if(Input.is_action_pressed("ui_cancel")):
		get_tree().quit()
	
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

func rand_element(l):
	var i = randi() % len(l)
	return l[i]

func change_scene(name):
	get_tree().change_scene("res://" + name + ".tscn")
