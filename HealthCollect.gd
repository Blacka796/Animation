extends Area2D

onready var audioPlay = $AudioStreamPlayer

func _ready():
	pass # Replace with function body.


func _on_HealthCollect_area_entered(area):
	if PlayerStats.health == PlayerStats.maxHealth:
		get_node("CollisionShape2D").disabled = true
	else:
		get_node("CollisionShape2D").disabled = false
		PlayerStats.health += 1
		queue_free()
