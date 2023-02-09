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
onready var animationPlayer = $AnimationPlayer

var knockBack = Vector2.ZERO
var velocity = Vector2.ZERO

var state = Chase

func _physics_process(delta):
	knockBack = knockBack.move_toward(Vector2.ZERO,friction * delta)
	knockBack = move_and_slide(knockBack)
	
	if state == Idle:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		findPlayer()
		animationPlayer.play("Idle")
		
	elif state == Attack:
		pass
	elif state == Chase:
		var player = playerDete.player
		if player != null:
			var direction = (player.global_position - global_position).normalized()
			velocity = velocity.move_toward(direction * maxSpeed, accel * delta)
			animationPlayer.play("Attack")
		else:
			state = Idle
	velocity = move_and_slide(velocity)

func findPlayer():
	if playerDete.canSeePlayer():
		state = Chase

func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	knockBack = area.knockBack_vector * 160
	hurtBox.HitEffect()


func _on_Stats_noHealth():
	queue_free() # Replace with function body.
