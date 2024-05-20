extends Control
@onready var text = $text
# Called when the node enters the scene tree for the first time.
func _ready():
	text.text = "CONGRATULATIONS! YOU'VE EARNED TOTAL OF " + str(global.score) + " POINTS"
	

func _on_restart_pressed():
	get_tree().change_scene_to_file("res://background.tscn")


func _on_quit_pressed():
	get_tree().quit()
