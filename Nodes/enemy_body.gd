extends CharacterBody2D
class_name enemy

const SPEED = 100.0
var playerEntered : = false

func _ready() -> void:
	# To make enemy attack when player enters the area marked connect signal
	$activateArea.connect("body_entered",playerEnter)
	$activateArea.connect("body_exited",playerExit)

func _process(_delta) -> void:
	move_and_slide()
	# to make the enemy look at player
	if playerEntered:
		look_at(Globals.PlayerPos)
	else:
		pass

func playerEnter(body):
	playerEntered = true
	
func playerExit(body):
	playerEntered = false
