extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var rest = $Sprite.position


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


func look_at(pos):
	var d = pos - global_position
	if d.length() < 100:
		$Sprite.global_position = global_position + d.normalized() * 3
		return true
	else:
		$Sprite.position = rest
	
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
