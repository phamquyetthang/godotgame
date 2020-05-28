extends StaticBody2D


onready var pos_l = get_node("position_l")
onready var camera = get_node("../../../Camera2D")
# Called when the node enters the scene tree for the first time.
func _ready():
	print(pos_l.position.x)
	print(camera.position.x)
	set_process(true)
	pass # Replace with function body.


func _process(delta):
	if camera == null:
		return
	if pos_l.global_position.x <= camera.get_total_pos().x:
		queue_free()
	pass



func _on_Area2D_body_entered(body):
	if "player" in body.name:
		body._is_dead()
