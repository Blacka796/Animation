extends Node2D

export var AttackRange = 32

onready var startPosition = global_position
onready var targetPosition = global_position
onready var timer = $Timer

func updateTargetPosition():
	var targetVector = Vector2(rand_range(-AttackRange, AttackRange), rand_range(-AttackRange, AttackRange))
	targetPosition = startPosition + targetVector
	
func _on_Timer_timeout():
	updateTargetPosition()
	
func getTimeLeft():
	return timer.time_left
	
func startAttackTimer(duration):
	timer.start(duration)
