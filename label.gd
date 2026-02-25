extends Label
var elapsed_time = 0.0
var is_stopped = true
func _ready() -> void:
	self.text = ("TIMER NOT STARTED")
	SignalBus.enemydie.connect(_on_enemy_die)
	SignalBus.start.connect(_on_start)
func _on_start():
	is_stopped = false
	elapsed_time = 0.0
func _process(delta: float) -> void:
	if is_stopped == false:
		elapsed_time += delta
		self.text = str(elapsed_time).pad_decimals(2)
func _on_enemy_die():
	is_stopped = true
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("delete"):
		is_stopped = true
