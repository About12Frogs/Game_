extends Control
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
func _on_button_pressed() -> void:
	queue_free()
	SignalBus.un_die.emit()
