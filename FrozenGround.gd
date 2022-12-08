extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# connect to body_entered signal
	connect("body_entered", self, "on_body_entered")
	# connect to body_exited signal
	connect("body_exited", self, "on_body_exited")


func on_body_entered(body):
	# if the body is a player
	if not body.is_in_group("Player"):
		return 
	
	body.rotation_lerp = body.frozen_lerp
	


# the above function but write it with types


func on_body_exited(body):
	if not body.is_in_group("Player"):
		return 
	
	body.rotation_lerp = body.normal_lerp
