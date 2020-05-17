extends Area2D


const speed = 500
var velocity = Vector2()
var direction = 1
func set_direction(dir):
	direction = dir
	if dir == -1 :
		$thuner.flip_h = true
		
func _physics_process(delta):
	velocity.x = speed * delta * direction
	$thuner.play("fly")
	translate(velocity)


func _on_VisibilityEnabler2D_screen_exited():
	queue_free()


func _on_ultimate_body_entered(body):
	if "enemies" in body.name:
		body.dead(5)
	queue_free()


func _on_ultimate_area_entered(area):
	area.queue_free()
	queue_free()
