extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var progressbar = $HBoxContainer/ProgressBar
onready var coin = $HBoxContainer/HBoxContainer/coin
onready var fire = $HBoxContainer/HBoxContainer/fire
onready var thuner = $HBoxContainer/HBoxContainer/thuner
onready var vantoc = $HBoxContainer/v/vantoc
func _on_player_update_live(hp):
	progressbar.value = hp


func _on_player_update_coin(coins):
	coin.text = str(coins)


func _on_player_update_fire(sfire):
	fire.text = str(sfire)


func _on_player_update_ulti(sulti):
	thuner.text = str(sulti)


func _on_player_update_speed(maxspeed):
	vantoc.text = str(maxspeed)
