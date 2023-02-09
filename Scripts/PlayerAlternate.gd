extends KinematicBody2D

onready var anim = $AnimationPlayer
onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")
onready var swordHitBox = $HitBox/SwordHitbox
onready var hurtBox = $Hurtbox

const accele = 700
const friction = 700
#const Max_Speed = 100
const dash_Speed = 200
var velocity = Vector2.ZERO
var dashVector = Vector2.DOWN

var stats = PlayerStats
var bulletSpeed = PlayerStats.bulletSpeed
var bullet = preload("res://Scenes/Bullet.tscn")

enum {
	Move,
	Dash,
	Attack
}

var state = Move

func _ready():
	stats.connect("noHealth", self, "queue_free")
	animTree.active = true
	swordHitBox.knockBack_vector = dashVector

func _physics_process(delta):
	if state == Move:
		moveState(delta)
	elif state == Attack:
		attackState(delta)
	elif state == Dash:
		dashState(delta)
	
func moveState(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		dashVector = input_vector
		swordHitBox.knockBack_vector = input_vector
		animTree.set("parameters/Idle/blend_position", input_vector)
		animTree.set("parameters/Run/blend_position", input_vector)
		animTree.set("parameters/Attack/blend_position", input_vector)
		animTree.set("parameters/Dash/blend_position", input_vector)
		animState.travel("Run")
		velocity = velocity.move_toward(input_vector * PlayerStats.Max_Speed, accele * delta)
	else:
		animState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	move()
	
	if Input.is_action_just_pressed("Dash"):
		state = Dash
	if Input.is_action_just_pressed("Attack"):
		state = Attack
	
	if PlayerStats.health <= 0:
		get_tree().change_scene("res://Scenes/LoseMenu.tscn")
	
func dashState(delta):
	velocity = dashVector * dash_Speed
	animState.travel("Dash")
	move()

func attackState(delta):
	velocity = Vector2.ZERO
	animState.travel("Attack")

func move():
	#velocity = move_and_slide(velocity * Max_Speed)
	#move_and_collide(velocity * delta * Max_Speed)
	velocity = move_and_slide(velocity)

func attackAnimFinish():
	velocity = Vector2.ZERO
	state = Move

func DashAnimFinish():
	state = Move


func _on_Hurtbox_area_entered(area):
	stats.health -= 1
	hurtBox.StartInvinc(0.5)
	hurtBox.HitEffect()

