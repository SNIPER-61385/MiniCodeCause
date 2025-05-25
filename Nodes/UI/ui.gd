extends CanvasLayer

#colors
var green: Color = Color("6bbfa3") 
var red : Color = Color(1,0,0,1) # R G B A (rgb alpha)
signal dayTimeEnd

@onready var laserCountLabel : Label = $LaserCounter/LaserCount/Count
@onready var dayTimer:= $Timer/TimerLabel
@onready var laserCountIcon : = $LaserCounter/LaserCount/Image
@onready var healthbar = $health/healthBar


var i : int

func _ready() -> void:
	$Timer/Daytime.connect("timeout",_onDaytimeEnd)
	updateLaserCount()
	updateHealth()
	updateScore()
	
func _process(_delta) -> void:
	updateTimer(int($Timer/Daytime.time_left))
	updateLaserCount()
	updateHealth()
	updateScore()
	
func updateScore():
	$score/scoreCounter.text = str(Globals.playerScore)

func updateTimer(timeLeft):
	dayTimer.text = str(timeLeft)
	
func updateLaserCount() -> void:
	laserCountLabel.text = str(Globals.bulletCount)
	updateNodeColor(laserCountLabel, Globals.bulletCount)
	updateNodeColor(laserCountIcon, Globals.bulletCount)
	
	
func updateHealth() -> void:
	healthbar.value = Globals.playerHealth
	
# function will udpate color of passed labels to green on amount and red on 0
func updateNodeColor(node, amount: int) -> void:
	if amount > 0:
		node.modulate = green
	else:
		node.modulate = red
	
	
func _onDaytimeEnd():
	dayTimeEnd.emit()
