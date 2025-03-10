extends Control

var active: bool = false

func _process(_delta):
	for fruit in $FallingFruits.get_children():
		if fruit.name != 'Huge':
			fruit.get_child(0).progress += randf_range(1.3, 1.9)


func _on_start_game_button_button_up():
	$Sounds/Click.play()
	$ColorRect.scale = Vector2(2, 2)
	var tween = create_tween()
	tween.tween_property($Sounds/Song, "volume_db", -60, 2)
	$AnimationPlayer.play("FadeIn")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Level/Map.tscn")


func _on_watermelon_button_button_up():
	$Sounds/Click.play()
	if not active:
		active = true
		var tween = create_tween()
		tween.tween_property($FallingFruits/Huge/Pa, "progress_ratio", 1.0, 5).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_CUBIC)
		await get_tree().create_timer(1.75).timeout
		$Sounds/Woosh.play()
		await tween.finished
		$FallingFruits/Huge/Pa.progress_ratio = 0.0
		active = false


func _on_start_game_button_mouse_entered():
	$Sounds/Select.play()


func _on_watermelon_button_mouse_entered():
	$Sounds/Select.play()


func _on_quit_button_button_up():
	get_tree().quit()
