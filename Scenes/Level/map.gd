extends Node2D

@onready var Strawberry: PackedScene = preload("res://Scenes/Fruits/strawberry.tscn")
@onready var Cherry: PackedScene = preload("res://Scenes/Fruits/cherry.tscn")
@onready var Grape: PackedScene = preload("res://Scenes/Fruits/grape.tscn")

func _process(_delta):
	if int(%StrCount.text) != $Player.Strawberries:
		%StrCount.text = str($Player.Strawberries)
	
func _spawn_fruit(fruit_type: PackedScene, fruit_name: String):
	var min_spawn_area = $SpawnLocations/Marker2D.global_position
	var max_spawn_area = $SpawnLocations/Marker2D2.global_position
	var random_pos = Vector2(
		randf_range(min_spawn_area.x, max_spawn_area.x),
		randf_range(min_spawn_area.y, max_spawn_area.y)
	)
	
	var fruit = fruit_type.instantiate()
	fruit.global_position = random_pos
	
	if fruit_name == 'Strawberry':
		$Fruits/Strawberry.add_child(fruit)
	elif fruit_name == 'Grape':
		$Fruits/Grape.add_child(fruit)
	elif fruit_name == 'Cherry':
		$Fruits/Cherry.add_child(fruit)
		
	Globals.entities += 1

func _on_strawberry_timer_timeout():
	if Globals.entities < 100:
		_spawn_fruit(Strawberry, 'Strawberry')

func _on_strawberry_shop_button_pressed():
	$Control/StrawberryShop.visible = !($Control/StrawberryShop.visible)

#===========================================================#
#-----------------------SHOP-BUTTONS------------------------#
#===========================================================#

func _on_strawberry_shop_purchase_range():
	if $Player.Strawberries >= %StrawberryShop.RangePrice:
			$Player.get_child(2).scale *= 1.1
			$Player.Strawberries -= %StrawberryShop.RangePrice

func _on_strawberry_shop_purchase_rate():
	if $Player.Strawberries >= %StrawberryShop.RatePrice:
			%StrawberryTimer.wait_time -= 0.05
			$Player.Strawberries -= %StrawberryShop.RatePrice

func _on_strawberry_shop_purchase_speed():
	if $Player.Strawberries >= %StrawberryShop.SpeedPrice:
		$Player.speed += 20
		$Player.Strawberries -= %StrawberryShop.SpeedPrice
