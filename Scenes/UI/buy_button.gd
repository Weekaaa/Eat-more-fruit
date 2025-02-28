extends Control

signal button_pressed

func _on_texture_button_pressed():
	button_pressed.emit()
	$AnimationPlayer.play("buy")
