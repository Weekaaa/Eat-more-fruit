extends Node2D

@onready var Strawberry: PackedScene = preload("res://Scenes/Fruits/strawberry.tscn")

func _process(_delta):
	pass
	
func _spawn_fruit():
	var min_spawn_area = $SpawnLocations/Marker2D.global_position
	var max_spawn_area = $SpawnLocations/Marker2D2.global_position
	var random_pos = Vector2(
		randf_range(min_spawn_area.x, max_spawn_area.x),
		randf_range(min_spawn_area.y, max_spawn_area.y)
	)
	var fruit = Strawberry.instantiate()
	fruit.global_position = random_pos
	$Strawberry.add_child(fruit)
	Globals.entities += 1
	print(Globals.entities)

func _on_strawberry_timer_timeout():
	if Globals.entities <= 100:
		_spawn_fruit()
