extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -100.0
const hook_speed = 60

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree: AnimationTree = $AnimationTree
var direction = Vector2.ZERO
#hook properties
var hook_initial_pos = Vector2.ZERO
var hook_throw_distance = 100
var target_pos = hook_initial_pos
var bottom_reached = false
@onready var fish_detection: Area2D = $Area2D
var score = 0

func _ready():
	animation_tree.active = true
	hook_initial_pos=$hooktexture.position.y
	target_pos.y+=185
func _process(delta):
	update_animation()
func _physics_process(delta):
	#hook
	# Check if the hook reached the bottom
	if ($hooktexture.position.y <= target_pos.y and bottom_reached==false):
		$hooktexture.position.y+=hook_speed*delta
		if $hooktexture.position.y >= target_pos.y:
			bottom_reached=true
	if ($hooktexture.position.y >= hook_initial_pos and bottom_reached==true):
		$hooktexture.position.y-=hook_speed*delta
		if $hooktexture.position.y <= hook_initial_pos:
			bottom_reached=false

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#input direction
	var direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_pressed("move_left"):
		$Body.flip_h = false
	if Input.is_action_pressed("move_right"):
		$Body.flip_h = true
	if Input.is_action_just_pressed("move_right") and $hooktexture.position.x<0:
		$hooktexture.position.x*=-1
		$hooktexture.flip_h=true
	if Input.is_action_just_pressed("move_left") and $hooktexture.position.x>0:
		$hooktexture.position.x*=-1
		$hooktexture.flip_h=false
	#animations
	#apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func update_animation():
	if(velocity == Vector2.ZERO):
		animation_tree["parameters/conditions/idle"] = true
		animation_tree["parameters/conditions/is_running"] = false
	else:
		animation_tree["parameters/conditions/idle"] = false
		animation_tree["parameters/conditions/is_running"] = true
	
	if(Input.is_action_just_pressed("throw")) and animation_tree["parameters/conditions/is_running"] == false:
		animation_tree["parameters/conditions/hook"] = false
		animation_tree["parameters/conditions/throw"] = true
		$Timer.start()
	if(Input.is_action_just_pressed("hook")):
		$HookInvisible.start()
		animation_tree["parameters/conditions/throw"] = false
		animation_tree["parameters/conditions/hook"] = true
		
	animation_tree["parameters/Idle/blend_position"] = direction
	animation_tree["parameters/hook/blend_position"] = direction
	animation_tree["parameters/throw/blend_position"] = direction
	animation_tree["parameters/run/blend_position"] = direction


func _on_timer_timeout():
	$hooktexture.visible = true
	$hooktexture.position.y = hook_initial_pos





func _on_hook_invisible_timeout():
	$hooktexture.visible = false
	$hooktexture.position.y = hook_initial_pos
