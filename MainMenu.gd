extends Node2D


var _storyButton = $Story
var _freeplayButton = $Free

func _ready():
	_storyButton.connect("button_down", self, "_on_storyButton_button_down")
	_freeplayButton.connect("button_down", self, "_on_freeplayButton_button_down")

func _on_storyButton_button_down():	
	G.GAMEMODE = "story"
	get_tree().change_scene("res://Characterselect.tscn")


func _on_storyButton_button_down():	
	G.GAMEMODE = "free"
	get_tree().change_scene("res://Characterselect.tscn")