extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_played = false

onready var lake_name = get_parent().name
export(PackedScene) var level

onready var video = get_tree().get_nodes_in_group("video")[0]


# Called when the node enters the scene tree for the first time.
func _ready():
	print("lake name: " + lake_name)
	if lake_name in G.levels_played or lake_name in G.levels_locked:
	# if "res://"+level+".tscn" in G.levels_played:
		modulate.a = 0.4
		is_played = true

	video.connect("finished", self, "change_scene_to_level")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_played and not G.GAMEMODE == "free":
		return
	if $Area2D.get_overlapping_bodies().size() == len(get_tree().get_nodes_in_group("Player")):
		#get_parent().start_level(level + ".tscn")
		G.current_level_position = global_position


		video.show()
		video.play()

		# wait for video to finish

		G.levels_played.append(lake_name)
		G.levels_locked = G.levels_locked.slice(1, G.levels_locked.size())
		
		
func change_scene_to_level():
	video.queue_free()
	get_tree().change_scene_to(level)


