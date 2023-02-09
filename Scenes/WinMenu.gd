extends CanvasLayer

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func _ready():
	PlayerStats.health = PlayerStats.maxHealth
