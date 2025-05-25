extends CharacterBody2D

#@onready var timerLabel = $Camera2D/UI/BackgroungHUD/Timer
#@onready var scoreLabel = $Camera2D/UI/BackgroungHUD/Score
#@onready var healthLabel = $Camera2D/UI/BackgroungHUD/Health

signal shoot(pos)

var shootFreq : bool = true

# use playerSpeed from globals
var speed = Globals.playerSpeed
var playerState

var isDead:bool

# use playerHealth from globals
var health = Globals.playerHealth
var maxHealth = 100
var score:int = 0
var timeRemaining = 60

func _ready():
	$Timer.start()
	$AnimatedSprite2D.visible = false
	#$Camera2D/UI/GameOver.visible = false
	
	#ShootTimerConnect
	$shootTimer.connect("timeout",_shootFreq)
	
func _process(_delta):
	#move
	var direction = Input.get_vector("left", "right", "up", "down")
	move(direction)
	playAnimation(direction)
	
	#shoot emmited to mainGame
	
	if Input.is_action_pressed("shoot") and shootFreq:
		var pos = $ak36/Marker2D.global_position
		var shootDirec = (get_global_mouse_position() - self.global_position).normalized()
		if Globals.bulletCount > 0:
			shoot.emit(pos, shootDirec)
		$shootTimer.start()
		shootFreq = false
	
	#sets player position in global script for using in other scenes
	Globals.PlayerPos = self.global_position
	
	#keep on setting playerHealth and speed so that they can be updated in global script
	Globals.playerHealth = health
	Globals.playerSpeed = speed
	
	#ui
	#setLabels()
	
	#death
	isDead = health <= 0 || timeRemaining == 0
	if (isDead):
		gameOver()
		
func gameOver():
		#show game over screen
		$Camera2D/UI/GameOver.visible = true
		#hide HUD
		$Camera2D/UI/BackgroungHUD.visible = false
		#show score
		#show "back to main menu" button
		#go back to the main menu
	
#shootTimer Connected on ready
func _shootFreq() -> void:
	shootFreq = true

#func setLabels():
	#healthLabel.text = str(health, "/", maxHealth)
	#scoreLabel.text = str(score)
	#timerLabel.text = str(timeRemaining)
	
func move(dir):

	if (dir.x == 0 && dir.y == 0):
		playerState = "idle"
	elif (dir.x != 0 || dir.y != 0):
		playerState = "walking"
		
	velocity = dir * speed
	move_and_slide()

func playAnimation(dir):
	if (playerState == "walking"):
		
		#Cardnal
		if (dir.y == -1):
			$AnimatedSprite2D.play("n_walk")
			return
		if (dir.x == 1):
			$AnimatedSprite2D.play("e_walk")
			return
		if (dir.y == 1):
			$AnimatedSprite2D.play("s_walk")
			return
		if (dir.x == -1):
			$AnimatedSprite2D.play("w_walk")
			return
			
		#Intermediate
		if (dir.x > 0.5 && dir.y < -0.5):
			$AnimatedSprite2D.play("ne_walk")
		if (dir.x > 0.5 && dir.y > 0.5):
			$AnimatedSprite2D.play("se_walk")
		if (dir.x < -0.5 && dir.y > 0.5):
			$AnimatedSprite2D.play("sw_walk")
		if (dir.x < -0.5 && dir.y < -0.5):
			$AnimatedSprite2D.play("nw_walk")
	
func _on_timer_timeout():
	if (timeRemaining > 0):
		timeRemaining -= 1
		$Timer.start()
		if (health <= 0):
			isDead = true
	else:
		isDead = true

func takeTamage(damage):
	health -= damage

func heal(addHealth):
	health += addHealth

func addScore(aScore):
	score += aScore
