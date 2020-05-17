extends Area2D

func _physics_process(delta):
	delta = delta
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "player":
			body.set_hp(-1)
			queue_free()
	
