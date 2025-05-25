extends Area2D

var direction: Vector2
var bulletSpeed := 200


func _ready() -> void:
	self.connect("body_entered", _on_body_entered)
	self.connect("area_entered", _on_body_entered)
	
func _process(delta) -> void:
	self.position += direction * delta * bulletSpeed
	#self.velocity += 1
	
func _on_body_entered(body) -> void:
	if body.has_method("hit") == true:
		body.hit()
	queue_free()

		
