extends Node

export var maxHealth = 1 setget SetMaxHealth
var health = maxHealth setget setHealth

var Max_Speed = 100
export var PlayerDamage = 1

var bulletSpeed = 1000

signal noHealth
signal healthChange(val)
signal maxHealthChange(val)

func _ready():
	self.health = maxHealth

func SetMaxHealth(val):
	maxHealth = val
	self.health = min(health, maxHealth)
	emit_signal("maxHealthChange", maxHealth)

func setHealth(val):
	health = clamp(val, 0, maxHealth)
	emit_signal("healthChange", health)
	if health <= 0:
		emit_signal("noHealth")


