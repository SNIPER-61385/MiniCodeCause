extends Node

var PlayerPos : Vector2

var playerHealth : int = 1 :
	get:
		return playerHealth
	set(value):
		playerHealth += value
var bulletCount : int = 1 :
	get:
		return bulletCount
	set(value):
		bulletCount += value
var playerSpeed : int = 100:
	get:
		return playerSpeed
	set(value):
		playerSpeed += value
