extends Node2D

#signal emmitted to mainGame
signal shoot(pos,direc)

func _process(delta: float) -> void:
	#shoot
	if Input.is_action_pressed("shoot"):
		shoot.emit(self.global_position,direction)
