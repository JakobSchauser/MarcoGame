
extends Sprite


export(String) var color


# Called when the node enters the scene tree for the first time.
func _ready():
	modulate = G.colors[color]



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
