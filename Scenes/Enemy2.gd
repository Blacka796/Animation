extends KinematicBody2D

enum {
	Idle,
	Attack,
	Chase
}

export var accel = 200
export var maxSpeed = 50
export var friction = 200

onready var stats = $Stats
onready var playerDete = $PlayerDete
onready var hurtBox = $Hurtbox
onready var attackControl = $AttackCnotrol
onready var sprite = $AnimSprite

var knockBack = Vector2.ZERO
var velocity = Vector2.ZERO

var state = Chase

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO,friction * delta)
	knockBack = move_and_slide(knockBack)
	
	if state == Idle:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		findPlayer()
		
	if attackControl.getTimeLeft() == 0:
		state = pickNewState([Idle, Attack])
		attackControl.startAttackTimer(rand_range(1, 3))
		
	elif state == Attack:
		findPlayer()
		if attackControl.getTimeLeft() == 0:
			state = pickNewState([Idle, Attack])
			attackControl.startAttackTimer(rand_range(1, 3))
		
		var direction = global_position.direction_to(attackControl.targetPosition)
		velocity = velocity.move_toward(direction * maxSpeed, accel * delta)
		
		if global_position.distance_to(attackControl.targetPosition) <= maxSpeed:
			state = pickNewState([Idle, Attack])
			attackControl.startAttackTimer(rand_range(1, 3))
		
	elif state == Chase:
		var player = playerDete.player
		if player != null:
			var direction = global_position.direction_to(player.global_position)
			velocity = velocity.move_toward(direction * maxSpeed, accel * delta)
		else:
			state = Idle
	
		sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)

func findPlayer():
	if playerDete.canSeePlayer():
		state = Chase
		
func pickNewState(state):
	state.shuffle()
	return state.pop_front()

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockBack = area.knockBack_vector * 160
	hurtBox.HitEffect()


func _on_Stats_noHealth():
	queue_free() # Replace with function body.
