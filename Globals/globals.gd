extends Node

var PlayerPos : Vector2
var playerScore: int = 0: 
	get:
		return playerScore
	set(value):
		playerScore = value

var playerHealth : int = 1 :
	get:
		return playerHealth
	set(value):
		playerHealth = value
var bulletCount : int = 10 :
	get:
		return bulletCount
	set(value):
		bulletCount = value
var playerSpeed : int = 100:
	get:
		return playerSpeed
	set(value):
		playerSpeed = value
