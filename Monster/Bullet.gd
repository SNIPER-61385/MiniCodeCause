extends Node2D

const speed = 100

func _ready() -> void:
	self.connect("body_entered", _on_body_entered)
	#self.connect("area_entered", _on_body_entered)

func _process(delta):
	position += transform.x * speed * delta


func _on_KillTimer_timeout() -> void:
	queue_free()
	
func _on_body_entered(body) -> void:
	if body.has_method("hit") == true:
		body.hit()
	for bodies in get_tree().get_nodes_in_group("enemy"):
		if body != bodies:
			queue_free()
