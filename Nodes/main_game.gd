extends Node2D

var bullet: PackedScene = preload("res://Nodes/bullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Player/CharacterBody2D.connect("shoot",playerShoot)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func playerShoot(pos, direction):
	var bullet := bullet.instantiate() as Area2D
	bullet.position = pos
	bullet.direction = direction
	$Projectiles.add_child(bullet)
	
