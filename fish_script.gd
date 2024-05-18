extends CharacterBody2D
@export var speed = randf_range(100, 180)
var initial_timer = 0.0
var timer = 0.0
var direction = 1
var scaling = randf_range(0.25,1.75)
var price = speed/scaling
func _ready():
	var animated_sprite_2d = $AnimatedSprite2D
	animated_sprite_2d.scale *= scaling
func _physics_process(delta):
	timer += delta
	initial_timer += delta
	if initial_timer >= randf_range(5.0, 9.0):
		if timer >= randf_range(2.0, 10.0):
			direction = -direction
			if direction == 1:
				$AnimatedSprite2D.flip_h = false
			else:
				$AnimatedSprite2D.flip_h = true
			timer = 0.0
	self.position.x += speed*delta*direction



