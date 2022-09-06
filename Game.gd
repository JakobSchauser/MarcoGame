extends Node2D

var segments = []
# onready var lake = $L

export(PackedScene) var player_scene

var players = []
var ui_dict = {}

var total_time = 0
export (PackedScene) var vegetation

onready var vegetation_factory = vegetation.instance()


onready var playerUI = preload("res://IndividualUI.tscn")  

onready var powerup_images = {"":preload("lake.png"),"Reversed controls":preload("lake.png"),"Slow others":preload("res://cornerrock.png"),"Stun":preload("res://goal.JPG"),"Boost":preload("res://arrowmarco.png"),"Lives":preload("res://grass1.png")}
# onready var powerup_images = {}
func check_collision(trails, player):
	for t in trails:
		var closest_point : Vector2 = Geometry.get_closest_point_to_segment_2d(player.position, t[0], t[0+1])
		if closest_point.distance_squared_to(player.position) <= player.radius:
			return t
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lap.connect("race_over", self, "on_race_over")
	
	for i in range(len(G.players_data)):
		var d = G.players_data[i]
		var p = player_scene.instance()
		p.worm_name = d["name"]
		p.player_num = d["player_num"]
		p.color = d["color"]
		p.global_position = $StartPositions.get_child(i).global_position
		$Players.add_child(p)
		p.connect("PickedUp", self, "on_update_powerup")
		players.append(p)
		
		
		# for pp in players:
		var l = playerUI.instance()
		
		l.get_node("Label").text = "3"
		l.modulate = p.color
		
		ui_dict[p.worm_name] = l 
		
		$CanvasLayer/CenterContainer/VBoxContainer/CharacterUI.add_child(l)
		
		on_update_powerup(p,p.held_powerup)
	

		
	# players = get_tree().get_nodes_in_group("Player")
	
	
	for p in players:
		$Camera2D.add_target(p)

	# print("Herro")
	var n_vegs = vegetation_factory.get_child_count()
	for _i in range(500):
		var x = rand_range(-200,1000)
		var y = rand_range(-500,1000)

		
		var inst = vegetation_factory.get_child(randi() % n_vegs).duplicate()
		inst.flip_h = rand_range(0,1) > 0.5
		inst.speed_scale += rand_range(-0.1, 0.1)

		inst.position = Vector2(x,y)

		var sx = rand_range(0.5,1) * sign(rand_range(-1,1))

		inst.scale = Vector2(sx/10,abs(sx)/10)


		inst.z_index = -100
		add_child(inst)
		

		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func get_kills():
	var kills = []
	for p in players:
		for q in players:
			var c = check_collision(p.points, q)
			if c:
				p.points.erase(c)
				kills.append([p, q]) 

	return kills

func on_race_over():
	remove_child($Players)
	get_tree().change_scene("res://Gameover.tscn")




func on_update_powerup(worm, power):
	ui_dict[worm.worm_name].get_node("Control/TextureRect").texture = powerup_images[power]


func update_lives(worm,lives):
	ui_dict[worm.worm_name].get_node("Label").text = str(lives)
	


func _process(delta):
	total_time += delta
	# update()
	var kills = get_kills()
	if kills.size() != 0:
		for k in kills:
			var p = k[1]
			p.lives -= 1
			update_lives(p,p.lives)
			if p.lives <= 0 and not p.is_dead:
				p.kill()
				# get_tree().reload_current_scene()
		# pass
	$Camera2D.position = avg_pos(players)

	if Input.is_action_just_pressed("ui_accept"):
		print("yay")
		on_race_over()


func avg_pos(objs):
	var pos = Vector2()
	for p in objs:
		pos += p.position
	
	return pos / objs.size()

func on_add_segment(segment):
	segments.append(segment)
