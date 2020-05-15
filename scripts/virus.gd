extends Area2D

func _physics_process(delta):
	$cc.play('quay')
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			queue_free()
	
