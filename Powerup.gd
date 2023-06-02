extends Area2D
# Force hole by janking into other snake
# Slalom
# Destroy all snake bodies

onready var types = ["Lives","Slow others","Reversed controls","Boost","Stun"]
onready var type = types[randi() % types.size()]

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Spawned a powerup")
	connect("body_entered",self,"on_body_entered")
	# create a timer and connect it to the timeout signal
	# when the timer times out, queue_free this instance 
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.start(10)
	


func on_body_entered(body):
	if body.is_in_group("Player"):
		body.give_power(type)
		body.play_pickup()
		
		queue_free()
