extends CollisionPolygon2D

export(String) var color = "blue"

func _ready():
	call_deferred("setup")

func setup():
	# Create a polygon 
	var p = Polygon2D.new()
	var s = polygon
	for i in range(s.size()):
		s[i] = s[i] + position

	p.polygon = s
	get_parent().add_child(p)
	p.modulate = G.colors[color]
