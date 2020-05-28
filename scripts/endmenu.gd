extends Node


onready var scores = $MarginContainer/VBoxContainer/VBoxContainer/Scores/Label
func _ready():
	#print(GLOBAL.coins)
	scores.text = str(GLOBAL.coins)
	pass
func _on_play_pressed():
	get_tree().change_scene("res://scenes/world.tscn")
	pass


func _on_home_pressed():
	get_tree().change_scene("res://scenes/menu.tscn")
	pass # Replace with function body.


func _on_exit_pressed():
	get_tree().quit()
	pass # Replace with function body.
