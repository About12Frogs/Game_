extends Area3D
func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	pass
#print doesnt work
