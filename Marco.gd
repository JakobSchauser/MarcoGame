extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var boost = 2

var speed = 100
var turnspeed = 2.3
var angle = 0

var radius = 10
var spawn_hole = 1

export var player_num = 0

var t = 0


onready var collision_timer = Timer.new()
onready var draw_timer = Timer.new()

var points = []

var colors = [Color.red, Color.green]

onready var color = colors[player_num]

var lastpos = position 


var fake_pos = Vector2()

# onready var line : Line2D = $Line2D
# Called when the node enters the scene tree for the first time.
func _ready():
	collision_timer.connect("timeout",self,"on_collision_timeout")
	add_child(collision_timer)
	collision_timer.wait_time = 0.1
	collision_timer.one_shot = false
	collision_timer.start()

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

func _process(delta):
	t += delta
	if Input.is_action_pressed("left"+str(player_num)):
		angle -= turnspeed*delta
	if Input.is_action_pressed("right"+str(player_num)):
		angle += turnspeed*delta
	
	var spd = speed
	if Input.is_action_pressed("boost"+str(player_num)):
		spd *= 2
		boost = max(0, boost - delta)

	var movevec = Vector2(cos(angle),sin(angle))*spd

	
	# line.points = points
	
	var off = movevec*delta
	
	fake_pos += off
	
	position = fake_pos + off * radius
	
	spawn_hole = max(0, spawn_hole - delta)

	if rand_range(0, 1) > 0.995 and spawn_hole <= 0:
		spawn_hole = 0.5


func on_collision_timeout():
	if spawn_hole <= 0:
		points.append([lastpos, fake_pos])

func on_draw_timeout():
	if spawn_hole <= 0:
		var l =	Line2D.new()
		l.width = 5
		l.points =[lastpos, fake_pos]
		l.default_color = color

		add_child(l)
		l.set_as_toplevel(true)
	lastpos = fake_pos

