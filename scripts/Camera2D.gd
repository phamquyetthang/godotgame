extends Camera2D


onready var player = get_node("../player")

func _ready():
	set_physics_process(true)
	pass

func _physics_process(delta):
	position = Vector2(player.position.x-100, position.y)
func get_total_pos():
	return position + offset
