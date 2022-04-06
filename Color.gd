
extends Sprite


export(String) var color
export(bool) var outline = false
export(Color) var outline_color
export(float) var wobble_amount = 1
export(float) var wobble_time = 0


onready var outline_res = preload("res://outline.tres")
onready var wobble_res = preload("res://wobble.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	self_modulate = G.colors[color]

	if outline:
		# material = outline_res.duplicate()
		# material.set_shader_param("color",outline_color)
		# material.set_shader_param("MyModulateColor",G.colors[color])
		# var dup = duplicate(0)
		var dup = Sprite.new()

		dup.texture = texture

		dup.set_script(wobble_res)
		dup.self_modulate = outline_color
		dup.position = Vector2(0,0)
		dup.show_behind_parent = true
		dup.wobble_amount = wobble_amount
		dup.wobble_time = wobble_time
		add_child(dup)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
