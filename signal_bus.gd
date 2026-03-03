extends Node
signal enemydie
signal un_die
signal start
signal menu_close
signal menu_open
signal chosen_bot(int)
var type = null
func _ready() -> void:
	chosen_bot.connect(_on_bot_chosen)
func _on_bot_chosen(bot: int):
	type = bot
