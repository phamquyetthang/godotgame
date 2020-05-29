extends KinematicBody2D


var motion = Vector2()
export var maxspeed = 150
export var jump = 350
export var g = 10
export(int) var hp = 10
const FIREBALL = preload("res://scenes/fireball.tscn")
const ULTI = preload("res://scenes/ultimate.tscn")
var dev_mod = false
var is_live = true
var is_start = false
signal update_live()
signal update_coin()
signal update_fire()
signal update_ulti()
signal update_speed()
signal died()
var coins = 0
var sfire = 3
var sulti = 0
func _ready():
	if GLOBAL.musicOn == true:
		$seno.play()
func _is_dead():
	is_live = false
	if GLOBAL.soundOn == true:
		$died.play()
	if not is_on_floor():
		$cute.position = Vector2(0, 48)
	$CollisionShape2D.call_deferred("set_disabled", true)
	motion = Vector2(0, 0)
	$cute.play("dead")
	$TimerDead.start()
	emit_signal("died", is_live)
	
func _is_live():
	motion.y += g
	if dev_mod == false:
		motion.x = min(motion.x+20, maxspeed)
		$cute.play("run")
		$cute.flip_h = false
		$cute.position = Vector2(0, 1)
		emit_signal("update_speed", maxspeed)
	if Input.is_action_pressed("on_mod"):
		motion.x = 0
		$cute.play('idle')
		dev_mod = true
		#GLOBAL.neverdie = true
		emit_signal("died", is_live)
	elif Input.is_action_pressed("off_mod"):
		dev_mod = false
		emit_signal("died", is_live)
	if is_on_floor():
		if Input.is_action_just_pressed("my_up"):
			motion.y = -jump
			if GLOBAL.soundOn == true:
				$jump.play()
	else:
		if motion.y < 0:
			$cute.play("jump")
		else:
			$cute.play("fall")
	if Input.is_action_just_pressed("my_attack"):
		skill_q()
	if Input.is_action_just_pressed("my_ulti"):
		skill_r()
	motion = move_and_slide(motion, Vector2(0, -1))
	
	if get_slide_count() > 0:
		for i in range (get_slide_count()):
			if "enemies" in get_slide_collision(i).collider.name:
				hp = 0
				emit_signal("update_live", hp)
				get_slide_collision(i).collider.dead(10)
				_is_dead()
func skill_q():
	if sfire > 0:
		var ballposition = sign($Position2D.position.x)
		$Position2D.position = Vector2(30, 0)
		var fileball = FIREBALL.instance()
		fileball.set_direction(ballposition)
		get_parent().add_child(fileball)
		if GLOBAL.soundOn == true:
			$shoot_q.play()
		fileball.position = $Position2D.global_position
		set_fire(-1)

func skill_r():
	if sulti > 0:
		var ballposition = sign($Position2D.position.x)
		$Position2D.position = Vector2(30, -10)
		var ulti = ULTI.instance()
		ulti.set_direction(ballposition)
		get_parent().add_child(ulti)
		if GLOBAL.soundOn == true:
			$shoot_r.play()
		ulti.position = $Position2D.global_position
		set_ulti(-1)

func _physics_process(delta):
	delta = delta
	if is_start == false:
		motion.y += g
		motion = Vector2(0, 0)
		$cute.play("idle")
	elif is_start == true:
		if is_live == true:
			_is_live()
	
	

func _on_Timer_timeout():
	maxspeed += 20

func _on_TimerDead_timeout():
	get_tree().change_scene("res://scenes/endmenu.tscn")

func _on_TimerStart_timeout():
	is_start = true

func set_coin(x):
	coins+=x
	GLOBAL.coins = coins
	if GLOBAL.soundOn == true:
		$audiocoin.play()
	emit_signal("update_coin", coins)

func set_fire(x):
	sfire += x
	emit_signal("update_fire", sfire)
func set_ulti(x):
	sulti += x
	emit_signal("update_ulti", sulti)
func set_hp(n):
	hp += n
	if GLOBAL.soundOn == true:
		$audiovirus.play()
	emit_signal("update_live", hp)
