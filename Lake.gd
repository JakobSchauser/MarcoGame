extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export(String) var level

var is_played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	if "res://"+level+".tscn" in G.levels_played:
		modulate.a = 0.2
		is_played = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not is_played and $Area2D.get_overlapping_bodies().size() > 0:
		get_parent().start_level(level + ".tscn")
		queue_free()
