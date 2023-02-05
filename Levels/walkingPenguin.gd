extends KinematicBody2D


onready var positions = get_parent().get_node("positions").get_children()
export var speed = 50
var current_position = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_position < positions.size():
		var target = positions[current_position].position
		var distance = target.distance_to(get_global_position())
		if distance > 1:
			var direction = (target - get_global_position()).normalized()
			var velocity = direction * speed
			move_and_slide(velocity)
		else:
			current_position += 1
	else:
		current_position = 0

	
