extends CharacterBody2D

@onready var timerLabel = $Camera2D/UI/BackgroungHUD/Timer
@onready var scoreLabel = $Camera2D/UI/BackgroungHUD/Score
@onready var healthLabel = $Camera2D/UI/BackgroungHUD/Health


var speed = 120
var playerState

var isDead:bool

var health = 100
var maxHealth = 100
var score:int = 0
var timeRemaining = 60

func _ready():
	$Timer.start()
	$AnimatedSprite2D.visible = false

func _process(delta):
	#move
	var direction = Input.get_vector("left", "right", "up", "down")
	move(direction)
	playAnimation(direction)
	
	#ui
	setLabels()
	

func setLabels():
	healthLabel.text = str(health, "/", maxHealth)
	scoreLabel.text = str(score)
	timerLabel.text = str(timeRemaining)
	
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

func addScore(addScore):
	score += addScore
