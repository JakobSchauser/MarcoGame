extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var level
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if $Area2D.get_overlapping_bodies().size() > 0:
		print("NOWW")
		get_parent().start_level(level + ".tscn")
		queue_free()
