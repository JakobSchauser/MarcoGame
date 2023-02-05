extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var high_tide = false
var s = 0


onready var label = get_parent().get_node("CanvasLayer/CenterContainer/VBoxContainer/TideLabel")

onready var tide: StaticBody2D = null
# Called when the node enters the scene tree for the first time.
func _ready():

	tide = get_node("HighTide")

	on_low_tide()
	# wait ten seconds
	yield(get_tree().create_timer(10), "timeout")
	
	on_high_tide()
	
func on_low_tide():
	label.text = "Tide is low"
	# remove_child(tide)
	high_tide = false	
	yield(get_tree().create_timer(7), "timeout")
	label.text = "High tide in 5 seconds!"
	yield(get_tree().create_timer(5), "timeout")
	on_high_tide()
	
func _process(delta):
	if(high_tide == true):
		s = lerp(s, 1, 0.02)
	else:
		s = lerp(s, 0, 0.02)
		
	tide.scale = Vector2(s,s)
			
func on_high_tide():
	label.text = "Tide is high"
	high_tide = true
	yield(get_tree().create_timer(30), "timeout")
	label.text = "Low tide in 5 seconds!"
	yield(get_tree().create_timer(5), "timeout")
	on_low_tide()	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
