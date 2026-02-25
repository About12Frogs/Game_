extends NavigationRegion3D

var is_spawned = false
@onready var enemys: PackedScene = preload("res://enemy.tscn")
const ui = preload("res://ui.tscn")
const player = preload("res://player.tscn")
const debug = preload("res://debug_instantiation.tscn")
@onready var playerpos = $player

func _ready() -> void:
	SignalBus.enemydie.connect(_on_enemydie)
	playerpos.global_position = Vector3(0, 1, 0)
	playerpos.global_rotation_degrees = Vector3(0, 180, 0)
func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "set_target_pos", playerpos.global_transform.origin)

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("start") and is_spawned == false:
		SignalBus.start.emit()
		var enemyg = enemys.instantiate()
		add_child(enemyg)
		is_spawned = true
	if Input.is_action_just_pressed("delete"):
		is_spawned = false


func _on_enemydie():
	var uig = ui.instantiate()
	add_child(uig)
	is_spawned = false
	playerpos.global_position = Vector3(0, 1, 0)
