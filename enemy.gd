extends CharacterBody3D
@onready var navagent: NavigationAgent3D = $NavigationAgent3D
@onready var player_import = $player
const SPEED = 7.1
func set_target_pos(targetpos):
		navagent.set_target_position(targetpos)
func _physics_process(delta: float) -> void:
	var destination = navagent.get_next_path_position()
	var local_destinaton = destination - global_position
	var direction = local_destinaton.normalized()
	velocity = direction * SPEED
	move_and_slide()
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("delete"):
		queue_free()



func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		SignalBus.enemydie.emit()
		
