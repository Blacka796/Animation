extends KinematicBody2D

onready var anim = $PlayerSprites

func _ready():
	self.global_position = Vector2(20,274)
	$AnimationPlayer.play("RunToDoor2")
