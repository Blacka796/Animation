extends Area2D

var timer = Timer.new() 

func _ready():
	pass # Replace with function body.


func _on_SpeedCollect_area_entered(area):
	if PlayerStats.Max_Speed == 130:
		get_node("CollisionShape2D").disabled = true
	else:
		get_node("CollisionShape2D").disabled = false
		PlayerStats.Max_Speed += 30
		queue_free()
