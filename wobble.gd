extends Sprite


export(float) var wobble_amount = 1.0
export(float) var wobble_time = 0.0
var t = 99
var startscale


func _ready():
	startscale = scale


func _process(delta):
	t += delta*wobble_time
	var s = wobble_amount * 0.05
	scale = Vector2(1 + abs(sin(t)*s),1 + abs(sin(t))*s)
