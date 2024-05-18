extends Sprite2D
@onready var game_manager = %GameManager
var is_hook_inside = false
var hooked_fish
func _on_area_2d_area_entered(area):
	if area.is_in_group("fish"):
		is_hook_inside = true
		hooked_fish = area.get_parent().get_parent()
		


func _on_area_2d_area_exited(area):
	if area.is_in_group("fish"):
		is_hook_inside = false
		hooked_fish = null
func _process(delta):
	if is_hook_inside and Input.is_action_just_pressed("hook"):
		game_manager.add_points(hooked_fish.price)
		hooked_fish.queue_free()
