extends CharacterBody3D
var alive = true
var mouse_active = true
@onready var neck = $neck
@onready var camera = $neck/Camera3D
const SPEED = 5.0
var relative_speed = SPEED
const JUMP_VELOCITY = 6
const MOUSE_SENS = 0.01
func _ready() -> void:
	SignalBus.enemydie.connect(_on_enemydie)
	SignalBus.un_die.connect(_on_un_die)
	SignalBus.menu_open.connect(_on_menu_open)
	SignalBus.menu_close.connect(_on_menu_close)

	
func _on_enemydie():
	alive = false
func _on_un_die():
	alive = true
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "front", "back")
	if Input.is_action_pressed("run"):
		relative_speed = SPEED * 1.5
	else:
		relative_speed = SPEED
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * relative_speed
		velocity.z = direction.z * relative_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
func _on_menu_open():
	mouse_active = false
func _on_menu_close():
	mouse_active = true
func _input(event: InputEvent) -> void:
	if alive and mouse_active:
		if Input.is_action_just_pressed("ui.exit"):
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode =Input.MOUSE_MODE_CAPTURED
		
		if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			rotate_y(-event.relative.x * MOUSE_SENS)
			neck.rotate_x(-event.relative.y * MOUSE_SENS)
		neck.rotation.x = clamp(neck.rotation.x, deg_to_rad(-60),deg_to_rad(70))
		
