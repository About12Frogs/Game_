extends HSlider

func _ready() -> void:
	self.value = SignalBus.sensitivity
func _on_value_changed(value: float) -> void:
	SignalBus.sensitivity = value
