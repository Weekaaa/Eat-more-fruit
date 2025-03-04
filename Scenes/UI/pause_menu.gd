extends Control

signal quitting()

func _on_quit_button_button_up():
	quitting.emit()
	Globals.player_quit.emit()
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()


func _on_close_button_button_up():
	$".".visible = false
