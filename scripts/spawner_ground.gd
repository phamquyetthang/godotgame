extends Node2D
# lap lai ban do

const scn_ground = preload("res://scenes/ground.tscn")
const GROUND_WIDTH = 6368
const AMOUNT_TO_FILL_VIEW = 2
func _ready():
# warning-ignore:unused_variable
	for i in range(AMOUNT_TO_FILL_VIEW):
		spawn_and_move()
	pass
func spawn_and_move():
	spawn_ground()
	go_next_pos()
func spawn_ground():
	var new_ground = scn_ground.instance()
	new_ground.position = position
	new_ground.connect("tree_exited", self, "spawn_and_move")
	get_node("contanner").add_child(new_ground)
	pass

func go_next_pos():
	position = position + Vector2(GROUND_WIDTH, 0)
	pass
