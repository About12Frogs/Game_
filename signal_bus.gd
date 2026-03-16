extends Node
signal enemydie
signal un_die
signal start
signal menu_close
signal menu_open
signal settings_open
signal settings_close
signal chosen_bot(int)
var sensitivity: float
var type = null
var opened = false
func _ready() -> void:
	chosen_bot.connect(_on_bot_chosen)
func _on_bot_chosen(bot: int):
	type = bot
func _input(event: InputEvent) -> void:
	if !opened:
		if Input.is_action_just_pressed("esc"):
			settings_open.emit()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
