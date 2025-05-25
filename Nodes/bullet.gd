extends Area2D

var direction: Vector2


func _ready() -> void:
	self.connect("body_entered", _on_body_entered)
	self.connect("area_entered", _on_body_entered)
	
func _process(_delta) -> void:
	self.position += direction
	#self.velocity += 1
	
func _on_body_entered(body) -> void:
	if body.has_method("hit") == true:
		body.hit()
	queue_free()

		
