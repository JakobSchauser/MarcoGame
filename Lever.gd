extends Area2D

var has_been_pulled = false

func _ready():
	connect("body_entered",self,"on_body_entered")


func on_body_entered(body):
	if not has_been_pulled and body.is_in_group("Player"):
		$Sprite.scale = $Sprite.scale*Vector2(-1,1)
		$Door.queue_free()
		has_been_pulled = true
	
