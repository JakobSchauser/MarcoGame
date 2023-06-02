extends Area2D


var hasstarted = false


func _ready():
	# yield(G.timer(0.05),"timeout")
	get_parent().get_node("Particles").color = get_parent().self_modulate

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		get_parent().get_node("Particles").emitting = true
		get_parent().self_modulate.a = 0
		yield(G.timer(1), "timeout")
		get_parent().queue_free()
