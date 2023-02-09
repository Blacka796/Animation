extends KinematicBody2D

onready var anim = $PlayerSprites

const Max_Speed = 100
var velocity = Vector2.ZERO

func _ready():
	anim.play("Idle")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		velocity = input_vector
	else:
		velocity = Vector2.ZERO
		
	move_and_collide(velocity * delta * Max_Speed)

