extends StaticBody2D
class_name container

signal open(pos, direction)

#without onready direction is calculated before ready and we get native direction instead of scene direction
@onready var current_direction = Vector2.DOWN.rotated(rotation)

func hit():
	print("item_contaner")
	
