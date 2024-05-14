extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -100.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation_tree: AnimationTree = $AnimationTree
func _ready():
	animation_tree.active = true
func _process(delta):
	update_animation()
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	#input direction
	var direction = Input.get_axis("move_left", "move_right")
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
	
	if(Input.is_action_just_pressed("throw")):
		animation_tree["parameters/conditions/throw"] = true
	if(Input.is_action_just_pressed("hook")):
		animation_tree["parameters/conditions/throw"] = false
		animation_tree["parameters/conditions/hook"] = true
