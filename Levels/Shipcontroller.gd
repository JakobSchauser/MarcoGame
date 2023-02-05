extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Port").connect("body_entered", self, "on_body_entered")


func on_body_entered(body):
	if body.is_in_group("Player"):
		# get the player
		var player = body
		player.global_position = get_node("Harbor").global_position

# TODO: Do not draw line
