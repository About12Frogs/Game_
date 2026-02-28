extends Control
var bot = null
@onready var lebron = $lebron
@onready var billy = $billy
@onready var label = $Label
# ---WORK IN PROGRESS---
"""Structure:
	- Change sprite texture in the mains script upon a SINGLE signal
	sent by the nextbot menu with string values for different choices
	- Format images to fit certain size, maybe add title and info?
	- Have the main script change the speed constant of the enemy and
	pathfinding stuff
	- animated sprites in the future maybe idk
	"""
func _ready() -> void:
	SignalBus.menu_close.connect(_on_menu_close)
	
func _on_menu_close():
	queue_free() 
func _on_lebron_pressed() -> void:
	bot = 1
	SignalBus.chosen_bot.emit(bot)
func _on_billy_pressed() -> void:
	bot = 2
	SignalBus.chosen_bot.emit(bot)
func _on_kitty_pressed() -> void:
	bot = 3
	SignalBus.chosen_bot.emit(bot)
func _process(delta: float) -> void:
	label.text = "debug: " + str(bot)
