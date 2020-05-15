extends KinematicBody2D


var motion = Vector2()
export var maxspeed = 300
export var jump = 350
export var g = 10
#const FIREBALL = preload("res://scenes/fireball.tscn")
func _physics_process(delta):
	motion.y += g
	motion.x = min(motion.x+20, maxspeed)
	$cute.play("run")
	$cute.flip_h = false
	if is_on_floor():
		if Input.is_action_just_pressed("my_up"):
			motion.y = -jump
	else:
		if motion.y < 0:
			$cute.play("jump")
		else:
			$cute.play("fall")
	
	motion = move_and_slide(motion, Vector2(0, -1))
