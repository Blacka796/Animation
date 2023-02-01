extends KinematicBody2D

onready var anim = $PlayerSprites

func _ready():
	$AnimationPlayer.play("Attack")
