extends Control

func _process(_delta):
	for fruit in $FallingFruits.get_children():
		fruit.get_child(0).progress += randf_range(1.3, 1.9)


func _on_start_game_button_button_up():
	$ColorRect.scale = Vector2(2, 2)
	$AnimationPlayer.play("FadeIn")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/Level/Map.tscn")
