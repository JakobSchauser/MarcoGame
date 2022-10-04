extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_played = false

onready var lake_name = get_parent().name
export(PackedScene) var level
# Called when the node enters the scene tree for the first time.
func _ready():
	if lake_name in G.levels_played:
	# if "res://"+level+".tscn" in G.levels_played:
		modulate.a = 0.2
		is_played = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_played:
		return
	if $Area2D.get_overlapping_bodies().size() == len(get_tree().get_nodes_in_group("Player")):
		#get_parent().start_level(level + ".tscn")
		G.current_level_position = global_position
		get_tree().change_scene_to(level)
		G.levels_played.append(lake_name)


