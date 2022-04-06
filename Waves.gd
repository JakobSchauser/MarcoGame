extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = 0
func _process(delta):
	t += delta/2
	material.set_shader_param("width",abs(sin(t)*10)+5)
