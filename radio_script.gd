extends Sprite2D
var is_playing = false
@onready var animation_player = $AnimationPlayer
@onready var audio_player = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("interact"):
		if not is_playing:
			animation_player.play("music_playing")
			audio_player.play()
			is_playing = true
		else:
			animation_player.play("RESET")
			audio_player.stop()
			is_playing = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
