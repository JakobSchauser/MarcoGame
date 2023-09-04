extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var is_played = false

onready var lake_name = get_parent().name.to_lower()
# export(PackedScene) var level

onready var lake_names = ["LakeTiticaca", "LakeLadoga", "LakeSuperior", "LakeTanganyika", "LakeBaikal", "LakeEyre", "LakeVostok"]
onready var level = 0 #load("res://levels/" +lake_name+ ".tscn")

onready var video = get_tree().get_nodes_in_group("video")[0]

onready var skip_label = video.get_parent().get_parent().get_node("SkipLabel")

# Called when the node enters the scene tree for the first time.
func _ready():
	var lvls = {}
	#lowercase the names
	for i in range(lake_names.size()):
		lake_names[i] = lake_names[i].to_lower()

	for name in lake_names:
		lvls[name] = load("res://levels/" +name+ ".tscn")
	
	level = lvls[lake_name]
	print("lake name: " + lake_name)
	print(level)
	# there is missing a parenthesis here
	if (G.GAMEMODE == "story") and (lake_name in G.levels_played or lake_name in G.levels_locked):
		get_parent().modulate.a = 0.4
		is_played = true

	video.connect("finished", self, "change_scene_to_level")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if video.is_playing():
		skip_label.show()
	else:
		skip_label.hide()
	
	if Input.is_action_just_pressed("ui_accept") and video.is_playing():
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

		# get camera
		var camera = get_tree().get_nodes_in_group("Camera")[0]
		camera.current = false

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


