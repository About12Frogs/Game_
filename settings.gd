extends Control



func _on_button_pressed() -> void:
	SignalBus.settings_close.emit()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
	
