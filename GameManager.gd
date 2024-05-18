extends Node2D
var score = 0
@onready var fish = $Fish
@onready var score_label = $Label
func add_points(price):
	score+=int(price)
	score_label.text = "SCORE "  \
	+ str(score)
