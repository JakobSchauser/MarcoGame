extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_played = false

onready var lake_name = get_parent().name
# export(PackedScene) var level
onready var level = load("res://levels/" +lake_name+ ".tscn")

onready var video = get_tree().get_nodes_in_group("video")[0]

onready var skip_label = video.get_parent().get_parent().get_node("SkipLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("lake name: " + lake_name)

	# there is missing a parenthesis here
	if (G.GAMEMODE == "story") and (lake_name in G.levels_played or lake_name in G.levels_locked):
		modulate.a = 0.4
		is_played = true

	video.connect("finished", self, "change_scene_to_level")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if video.is_playing():
		skip_label.show()
	else:
		skip_label.hide()
	
	if Input.is_action_just_pressed("ui_accept"):
		video.stop()
		# video.queue_free()
		change_scene_to_level()
		return
		
	

	if is_played and not G.GAMEMODE == "free":
		return
	if $Area2D.get_overlapping_bodies().size() == len(get_tree().get_nodes_in_group("Player")):
		if G.GAMEMODE == "free":
			change_scene_to_level()
			return
		
		#get_parent().start_level(level + ".tscn")
		G.current_level_position = global_position

		# ugly hack to put video on top
		# var p = video.get_parent()
		# p.remove_child(video)
		# p.add_child(video)

		# print("b4 video.play()")
		video.show()
		skip_label.show()
		video.play()
		# print("video.play()")

		# loop over all players
		for player in get_tree().get_nodes_in_group("Player"):
			# player.get_parent().remove_child(player)
			# move player to (0,0)
			player.global_position = Vector2(-9999,-999990)
			player.remove_tail_quick()
		# wait for video to finish

		G.levels_played.append(lake_name)
		G.levels_locked = G.levels_locked.slice(1, G.levels_locked.size())
		
		
func change_scene_to_level():
	# video.queue_free()
	get_tree().change_scene_to(level)


