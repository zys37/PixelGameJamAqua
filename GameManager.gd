extends Node2D
var throws_remaining = 12
@onready var fish = $Fish
@onready var score_label = $Label
@onready var throws = $"throws remaining"
@onready var info = $"game info"
func add_points(price):
	global.score+=int(price)
	score_label.text = "SCORE "  \
	+ str(global.score)
func delete_throws():
	throws_remaining-=1
	throws.text = "REMAINING THROWS "  \
	+ str(throws_remaining-1)
func _process(delta):
	if throws_remaining==0:
		get_tree().change_scene_to_file("res://ending_screen.tscn")
