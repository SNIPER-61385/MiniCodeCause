extends CharacterBody2D


const bullet_scene = preload("res://Monster/Bullet.tscn")
@onready var MonsterSprite = $Sprite2D
@onready var shoot_timer = $ShootTimer
@onready var rotater = $Rotater


const rotate_speed = 200
const shoot_timer_wait_time = 0.2
const spawn_point_count = 4
const radius = 50
const MonsterSpeed = 50


func _ready():	
	var step = 2 * PI / spawn_point_count
	
	for i in range(spawn_point_count):
		var spawn_point = Node2D.new()
		var pos = Vector2(radius, 0).rotated(step * i)
		spawn_point.position = pos
		spawn_point.rotation = pos.angle()
		rotater.add_child(spawn_point)
		
	shoot_timer.wait_time = shoot_timer_wait_time
	shoot_timer.start()


func _process(delta):
	var new_rotation = rotater.rotation_degrees + rotate_speed * delta
	rotater.rotation_degrees = fmod(new_rotation, 360)
	

func _physics_process(delta: float) -> void:
	var direction = (Globals.PlayerPos - position).normalized()
	
	if(position.distance_to(Globals.PlayerPos) > 100):
		position += direction * MonsterSpeed * delta 

func _on_ShootTimer_timeout() -> void:
	for s in rotater.get_children():
		var bullet = bullet_scene.instantiate()
		get_tree().root.add_child(bullet)
		bullet.position = s.global_position
		bullet.rotation = s.global_rotation	
		#bullet.speed = Bulletspeed
		
