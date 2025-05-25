extends container

@onready var chestHitOnce = false

func hit():
	if not chestHitOnce:
		$Sprite2D/AnimationPlayer.play("chestOpen")
		chestHitOnce = true
		await $Sprite2D/AnimationPlayer.animation_finished
		open.emit(global_position,current_direction)
		
	
