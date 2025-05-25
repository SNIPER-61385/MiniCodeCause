extends Area2D

#There will be 3 powerups
#1. Speed - white
#2. Bullet count - Red
#3. health - green

var rotation_speed : int = 3
var orbTypeList = ['life','life','bullet','bullet','bullet','speed']
var orbType = orbTypeList[randi() % orbTypeList.size()]
var directio : Vector2
var distance : int = randi_range(10,20)

func _ready() -> void:
	if orbType == 'life':
		$orbImage.modulate = Color(0.1,0.8,0.1)
	elif orbType == 'bullet':
		$orbImage.modulate = Color(0.1,0.1,0.8)
	elif orbType == 'speed':
		$orbImage.modulate = Color(0.8,0.1,0.1)
	self.connect("body_entered",_on_body_entered)
	self.connect("area_entered",_on_area_entered)
		
	#dropping animation
	var targetPos = position + directio * distance
	var dropOrb = create_tween()
	dropOrb.set_parallel(true)
	dropOrb.tween_property(self,"position",targetPos,.5)
	dropOrb.tween_property(self,"scale",Vector2(1,1),.3).from(Vector2.ZERO)
		
func _process(delta: float) -> void:
	rotation += rotation_speed * delta
	
func _on_body_entered(_body: Node2D) -> void:
	if orbType == 'life':
		Globals.playerHealth += 10
	elif orbType == 'laser':
		Globals.bulletCount += 5
	elif orbType == 'grenade':
		Globals.playerSpeed += 1
	#print(body.name)

	#print(orbType)
	#queue_free()
func _on_area_entered(_body: Node2D) -> void:
	queue_free()
