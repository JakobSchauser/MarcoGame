extends Node2D

var segments = []
# onready var lake = $L

var players = []

export (PackedScene) var grass

func check_collision(trails, player):
	for t in trails:
		var closest_point : Vector2 = Geometry.get_closest_point_to_segment_2d(player.position, t[0], t[0+1])
		if closest_point.distance_squared_to(player.position) <= player.radius:
			return t
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	$Lap.connect("race_over", self, "on_race_over")
	players = get_tree().get_nodes_in_group("Player")
	for p in players:
		$Camera2D.add_target(p)

	print("Herro")
	for i in range(500):
		var x = rand_range(0,1000)
		var y = rand_range(-500,1000)

		var inst = grass.instance()

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


# func _draw():
# 	for p in players:
# 		var pp = p.points
# 		for i in range(pp.size() - 1):
# 			draw_line(pp[i],pp[i+1],p.color,6)

func on_race_over():
	get_tree().reload_current_scene()



func _process(delta):
	# update()
	var kills = get_kills()
	if kills.size() != 0:
		for k in kills:
			k[1].lives -= 1
			if k[1].lives <= 0:
				get_tree().reload_current_scene()
		# pass
	$Camera2D.position = avg_pos(players)
	

func avg_pos(objs):
	var pos = Vector2()
	for p in objs:
		pos += p.position
	
	return pos / objs.size()

func on_add_segment(segment):
	segments.append(segment)
