extends Area2D

func _on_collision_shape_body_entered(body):
	if body.is_in_group("Player"):
		body.invinsible = false
		print(body.invinsible)