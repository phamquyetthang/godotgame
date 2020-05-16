extends KinematicBody2D


var motion = Vector2()
export var maxspeed = 150
export var jump = 350
export var g = 10
const FIREBALL = preload("res://scenes/fireball.tscn")
var dev_mod = false
func _physics_process(delta):
	motion.y += g
	if dev_mod == false:
		motion.x = min(motion.x+20, maxspeed)
		$cute.play("run")
		$cute.flip_h = false
	var ballposition = sign($Position2D.position.x)
	if Input.is_action_pressed("on_mod"):
		motion.x = 0
		$cute.play('idle')
		dev_mod = true
	elif Input.is_action_pressed("off_mod"):
		dev_mod = false
	if is_on_floor():
		if Input.is_action_just_pressed("my_up"):
			motion.y = -jump
	else:
		if motion.y < 0:
			$cute.play("jump")
		else:
			$cute.play("fall")
	if Input.is_action_just_pressed("my_attack"):
		var fileball = FIREBALL.instance()
		fileball.set_direction(ballposition)
		get_parent().add_child(fileball)
		fileball.position = $Position2D.global_position
	motion = move_and_slide(motion, Vector2(0, -1))


func _on_Timer_timeout():
	maxspeed += 20
