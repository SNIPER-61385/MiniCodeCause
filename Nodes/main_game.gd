extends Node2D

var bulletScene: PackedScene = preload("res://Nodes/bullet.tscn")
var orbSpawnScene: PackedScene = preload("res://Nodes/powerups.tscn")
var enemies : PackedScene = preload("res://Monster/Enemy.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/CharacterBody2D.connect("shoot",playerShoot)
	for containers in get_tree().get_nodes_in_group("containers"):
		#connecting from item_container
		containers.connect("open",spawnOrbs)
	$UI.connect("dayTimeEnd",_onDayTimeEnd)
	$DirectionalLight2D.energy = 0.0
		
func spawnOrbs(pos, direction):
	var orb: = orbSpawnScene.instantiate()
	orb.position = pos
	orb.directio = direction
	$Powerups.call_deferred("add_child",orb)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func playerShoot(pos, direction):
	var bullet := bulletScene.instantiate() as Area2D
	bullet.position = pos
	bullet.direction = direction
	$Projectiles.add_child(bullet)
	Globals.bulletCount -= 1
	print(Globals.bulletCount)


#On timer end begin nightTime
func _onDayTimeEnd() -> void:
	$DirectionalLight2D.energy = 0.5
	var enemy: = enemies.instantiate()
	enemy.scale = Vector2(0.25,0.25)
	enemy.position = Vector2(0,0)
	$Enemy.call_deferred("add_child",enemy)
	
