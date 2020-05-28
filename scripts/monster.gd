extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const g = 10
var maxspeed = 120
var velocity = Vector2()
var is_start = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	if is_start == false:
		velocity = Vector2(0, 0)
		$baby.play("idle")
	elif is_start == true:
		velocity.x = min(velocity.x+20, maxspeed*delta)
		$baby.play("run")
		translate(velocity)





func _on_Timer_timeout():
	maxspeed += 10
	pass # Replace with function body.


func _on_TimerStart_timeout():
	is_start = true
	pass # Replace with function body.


func _on_monster_body_entered(body):
	if "player" in body.name:
		body._is_dead()
		is_start = false


func _on_player_died():
	is_start = false
	pass
