extends Node2D

onready var p = get_parent()
var kinds = ["big_grass", "small_grass", "flower"]

# Called when the node enters the scene tree for the first time.
func _ready():
	p.flip_h = rand_range(0, 1) > 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
