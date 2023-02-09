extends Control

var heart = 5 setget setHeart

var maxHeart = 5 setget setMaxHeart

onready var heartFull = $HeartFull

func setHeart(val):
	heart = clamp(val, 0, maxHeart)
	if heartFull != null:
		heartFull.rect_size.x = heart * 1301
	
func setMaxHeart(val):
	maxHeart = max(val, 1)
	self.heart = min(heart, maxHeart)
	
func _ready():
	self.maxHeart = PlayerStats.maxHealth
	self.heart = PlayerStats.health
	PlayerStats.connect("healthChange", self, "setHeart")
	PlayerStats.connect("maxHealthChange", self, "setMaxHeart")
