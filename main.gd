extends NavigationRegion3D
var opened = false
var is_spawned = false
var player_alive = true
var timer_active = false
@onready var enemys: PackedScene = preload("res://enemy.tscn")
const ui = preload("res://ui.tscn")
const player = preload("res://player.tscn")
const debug = preload("res://debug_instantiation.tscn")
const menu = preload("res://nextbot_menu.tscn")
@onready var playerpos = $player

func _ready() -> void:
	SignalBus.enemydie.connect(_on_enemydie)
	SignalBus.chosen_bot.connect(_on_bot_chosen)
	SignalBus.un_die.connect(_on_respawn)
	playerpos.global_position = Vector3(0, 1, 0)
	playerpos.global_rotation_degrees = Vector3(0, 180, 0)
func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "set_target_pos", playerpos.global_transform.origin)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start"):
		var enemyg =enemys.instantiate()
		add_child(enemyg)
		is_spawned = true
	if Input.is_action_just_pressed("delete"):
		is_spawned = false
		timer_active = false
func _unhandled_input(event: InputEvent) -> void:
	if player_alive:
		if opened == false:
			if Input.is_action_just_pressed("open"):
				opened = true
				var menu_g = menu.instantiate()
				add_child(menu_g)
				SignalBus.menu_open.emit()
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		elif opened == true:
			if !Input.is_action_pressed("open"):
				opened = false
				SignalBus.menu_close.emit()
func _on_bot_chosen(bot:int):
	var enemyg = enemys.instantiate()
	add_child(enemyg)
	is_spawned = true
	if !timer_active:
		timer_active = true
		SignalBus.start.emit()

func _on_respawn():
	player_alive = true

func _on_enemydie():
	var uig = ui.instantiate()
	add_child(uig)
	is_spawned = false
	playerpos.global_position = Vector3(0, 1, 0)
	player_alive = false
	opened = false
	timer_active = false
