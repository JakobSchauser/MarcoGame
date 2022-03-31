extends KinematicBody2D





var boost = 0
var maxboost = 5
var basespeed = 100
var slowspeed = 50
var speed = basespeed
var turnspeed = 2.3
var angle = 0
var laps = 0

var joints_collison = 3
var joints_collison_count = 0


var should_spawn_powerups = false
var has_spawned = false

export(PackedScene) var powerup_scene 

var radius = 10
var spawn_hole = 0.1

export var player_num = 0

var current_line = null

var lives = 3  

var t = 0


onready var collision_timer = Timer.new()
onready var draw_timer = Timer.new()

var points = []

var colors = [G.red,G.green]

onready var color = colors[player_num]

var lastpos = position 

var vel_vec = Vector2()

var render_list = []

var fake_pos = Vector2()





# onready var line : Line2D = $Line2D
# Called when the node enters the scene tree for the first time.
func _ready():
	$Sprite.modulate = color
	spawn_line2d()
	# current_line.add_point(position)
	
	# collision_timer.connect("timeout",self,"on_collision_timeout")
	# add_child(collision_timer)
	# collision_timer.wait_time = 0.1
	# collision_timer.one_shot = true
	# collision_timer.start()
	
	connect("area_entered", self, "on_area_entered")

	draw_timer.connect("timeout",self,"on_draw_timeout")
	add_child(draw_timer)
	draw_timer.wait_time = 0.03
	draw_timer.one_shot = false
	draw_timer.start()

	# line.set_as_toplevel(true)
	# var movevec = Vector2(cos(angle),sin(angle))*speed
	# points.append([position - movevec,position - movevec])
	fake_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.



func get_closest_thing(things):
	var d = INF
	var o = null
	for thing in things:
		for p in G.group(thing):
			if p != self:
				var dd = (p.position - position).length()
				if dd < d:
					o = p
					d = dd
	return o



func move_dir():
	return Vector2(cos(angle),sin(angle))

func on_area_entered(area):
	if area.is_in_group("Lap"):
		var sgn = sign(move_dir().x) # Work only in levels with horizontal lap
		
		var max_laps = laps
		laps += sgn
		for p in get_tree().get_nodes_in_group("Player"):
			if p.laps > max_laps:
				max_laps = p.laps

		get_tree().get_nodes_in_group("LapLabel")[0].text = "Laps: " + str(max_laps)


func spawn_line2d():
	current_line = Line2D.new()
	current_line.joint_mode = 2
	current_line.begin_cap_mode = 2
	current_line.end_cap_mode = 2

	add_child(current_line)
	current_line.default_color = color
	current_line.width = 10
	current_line.set_as_toplevel(true)

func _process(delta):
	$Eyes.rotation = angle + PI / 2

	var p
	
	
	p = get_closest_thing(["Player","Powerup"]).position 
	for c in $Eyes.get_children():
		c.look_at(p)


	$ProgressBar.value = boost
	$Lives.text = str(lives)
	t += delta
	var spd = speed


	if Input.is_action_pressed("left"+str(player_num)):
		angle -= turnspeed*delta
	if Input.is_action_pressed("right"+str(player_num)):
		angle += turnspeed*delta

	if Input.is_action_pressed("close"):
		get_tree().quit()

	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_pressed("boost"+str(player_num)) and boost > 0:
		spd *= 1.6
		boost = max(0, boost - delta)

	if Input.is_action_pressed("break"+str(player_num)):
		spd *= 0.6

	var movevec = Vector2(cos(angle),sin(angle))*spd


	var off = movevec#*delta
	
	
	
	#fake_pos += off
	
	#position = fake_pos + off.normalized()*0.5 * radius
	
	move_and_slide(off)
	fake_pos = position - off.normalized()*0.5 * radius
	
	if get_slide_count() > 0:
		var col = get_slide_collision(0)

		if col != null:
			if col.collider.is_in_group("Grass"):
				var bouncevec = movevec.bounce(col.normal)
				angle = atan2(bouncevec.y,bouncevec.x)
				collide_slow()
	spawn_hole = max(0, spawn_hole - delta)

	if rand_range(0, 1) > 0.995 and spawn_hole <= 0:
		should_spawn_powerups = rand_range(0,1) < 0.9999
		spawn_hole = 0.5
		spawn_line2d()

func make_collision():
	if spawn_hole <= 0:
		points.append([lastpos, fake_pos]) # Is used in game.gd 
	elif should_spawn_powerups and not has_spawned and spawn_hole <= 0.25:
		spawn_powerup(lastpos)

func on_draw_timeout():
	if spawn_hole <= 0:
		joints_collison_count = (joints_collison_count + 1)%joints_collison
		current_line.add_point(fake_pos)

	if joints_collison_count == 0:
		make_collision()
	lastpos = fake_pos


func spawn_powerup(pos):
	has_spawned = true
	yield(get_tree().create_timer(0.7),"timeout")
	var inst = powerup_scene.instance()
	inst.position = pos
	add_child(inst)
	inst.set_as_toplevel(true)
	has_spawned = false
	
func power_slow():
	speed = slowspeed
	yield(get_tree().create_timer(4),"timeout")
	speed = basespeed

func collide_slow():
	speed = 0.2*basespeed 
	yield(get_tree().create_timer(1),"timeout")
	speed = basespeed


func power_stun():
	speed = 0.0007
	yield(get_tree().create_timer(2),"timeout")
	speed = basespeed

func power_reverse():
	turnspeed *= -1
	yield(get_tree().create_timer(2),"timeout")
	turnspeed *= -1


func power_boost():
	boost = maxboost

func show_pickup(msg):
	$Pickup.show()
	$Pickup.text = msg
	yield(get_tree().create_timer(2),"timeout")
	$Pickup.hide()

