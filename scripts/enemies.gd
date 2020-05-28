extends KinematicBody2D


const gravity = 10
const speed = 50
var velocity = Vector2()
var direction = 1
var is_dead = false

export(int) var hp = 3

func dead(damage):
	hp -= damage
	if hp <= 0 :
		is_dead = true
		$CollisionShape2D.call_deferred("set_disabled", true)
		$enemy.position = Vector2(0,10)
		velocity = Vector2(0, 0)
		$enemy.play("dead")
		$Timer.start()


func _physics_process(delta):
	delta = delta
	if is_dead == false :
		velocity.x = speed * direction
		if direction == 1:
			$enemy.flip_h = false
		else:
			$enemy.flip_h = true
		$enemy.play("walk")
		velocity.y += gravity
		velocity = move_and_slide(velocity, Vector2(0, -1))
		if is_on_wall():
			direction *= -1




func _on_Timer_timeout():
	queue_free()


func _on_TimerLoop_timeout():
	direction *= -1
