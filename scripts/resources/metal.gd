extends Node3D

@onready var interaction: Area3D = $Interaction

func _ready() -> void:
	interaction.interact = _on_interact


func _on_interact():
	print("Aquired metal")
