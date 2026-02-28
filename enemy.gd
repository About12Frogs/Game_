extends CharacterBody3D
@onready var navagent: NavigationAgent3D = $NavigationAgent3D
@onready var player_import = $player
@onready var sprite = $Sprite3D #Importing nodes
@onready var mp = $AudioStreamPlayer3D
var default_img = preload("res://icon.svg")
var billy_img = preload("res://billy.png")
var lebron_img = preload("res://lebron.jpeg") #Importing files for different bots
var kitty_img = preload("res://cat.jpeg")
var lebron_mp: AudioStreamMP3 = preload("res://lebron-lebron-lebron-james-made-with-Voicemod.mp3")
var kitty_mp: AudioStreamMP3 = preload("res://Voicy_Funky town (low quality).mp3")
var speed = 7.0
func _ready() -> void:
	if SignalBus.type == 1:
		sprite.texture = lebron_img
		mp.stream = lebron_mp
		speed = 7.0
	elif SignalBus.type == 2: #Probably couldve done this more efficiently but idc
		sprite.texture = billy_img #Setting texture for different types of bots using a variable from the signal bus
		speed = 8.5
	elif SignalBus.type == 3:
		sprite.texture = kitty_img
		mp.stream = kitty_mp
		speed = 6.0
	mp.play() #plays the audio
func set_target_pos(targetpos):
		navagent.set_target_position(targetpos)
func _physics_process(delta: float) -> void:
	var destination = navagent.get_next_path_position()
	var local_destinaton = destination - global_position
	var direction = local_destinaton.normalized()
	velocity = direction * speed
	move_and_slide()
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("delete"):
		queue_free()

	
func _on_hitbox_body_entered(body):
	if body.is_in_group("player"):
		queue_free()
		SignalBus.enemydie.emit()
		
