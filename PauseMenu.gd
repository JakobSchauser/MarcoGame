extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (PackedScene) var scene = null
# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Button.connect("pressed", self, "on_button_pressed")
	$VBoxContainer/Button2.connect("pressed", self, "on_button_pressed2")
	$VBoxContainer/Button3.connect("pressed", self, "on_button_pressed3")

# tilbage til spillet
func on_button_pressed():
	get_parent().hide()
	Engine.time_scale = 1
	get_parent().get_parent().pause = false

func on_button_pressed2():
	pass

func on_button_pressed3():
	G.change_scene("Overworld")
