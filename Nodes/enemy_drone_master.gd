extends CharacterBody2D
class_name EnemyMaster

var isPlayaerInside : bool = false
var canLaser := true

signal laser(pos,direction)

func _ready()->void:
	#$TimerLaser.connect("timeout",_on_timerLaser_timeout)
	pass
	
func _process(_float) -> void:
	if isPlayaerInside:
		look_at(Globals.PlayerPos)
		var laserMarker : = $spawnmarkers.get_children()
		var laserPoint : = laserMarker[randi() % laserMarker.size()]
		var direction := (Globals.PlayerPos - global_position).normalized()
		if canLaser:
			laser.emit(laserPoint.global_position, direction)
			$LaserDestroyTimer.start()
			canLaser = false
			$TimerLaser.start()

func _on_timerLaser_timeout() :
	canLaser = true
	

func _on_scan_area_body_entered(_body: Node2D) -> void:
	isPlayaerInside = true


func _on_scan_area_body_exited(_body: Node2D) -> void:
	isPlayaerInside = false
