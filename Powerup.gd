extends Area2D
# Force hole by janking into other snake
# Slalom
# Destroy all snake bodies

var types = ["Lives","Slow others","Reversed controls","Boost","Stun"]
onready var type = types[randi() % types.size()]

# Called when the node enters the scene tree for the first time.
func _ready():
	connect("body_entered",self,"on_body_entered")


func on_body_entered(body):
	if body.is_in_group("Player"):
		body.give_power(type)
		body.play_pickup()
		
		queue_free()
