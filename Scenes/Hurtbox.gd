extends Area2D

const HitEffect = preload("res://Scenes/HitEffect.tscn")

var invincible = false setget setInvincible

signal invinciStart
signal invinciEnd

onready var timer = $Timer

func setInvincible(val):
	invincible = val
	if invincible == true:
		emit_signal("invinciStart")
	else:
		emit_signal("invinciEnd")

func HitEffect():
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position - Vector2(0, 8)

func StartInvinc(duration):
	self.invincible = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invinciStart():
	set_deferred("monitorable", false)
	monitorable = false


func _on_Hurtbox_invinciEnd():
	monitorable = true
