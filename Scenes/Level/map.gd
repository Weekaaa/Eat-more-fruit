extends Node2D

@onready var Strawberry: PackedScene = preload("res://Scenes/Fruits/strawberry.tscn")
@onready var Cherry: PackedScene = preload("res://Scenes/Fruits/cherry.tscn")
@onready var Grape: PackedScene = preload("res://Scenes/Fruits/grape.tscn")

func _process(_delta):
	if int(%StrCount.text) != Globals.Strawberries:
		%StrCount.text = Globals.fix_nums(Globals.Strawberries)
	
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

func _on_cherry_timer_timeout():
	_spawn_fruit(Cherry, 'Cherry')

func _on_strawberry_shop_button_pressed():
	$Control/StrawberryShop.visible = !($Control/StrawberryShop.visible)

#===========================================================#
#-----------------------SHOP-BUTTONS------------------------#
#===========================================================#

func _on_strawberry_shop_purchase_range():
	if Globals.Strawberries >= Globals.RangePrice:
		$Player.get_child(2).scale *= 1.1
		Globals.Strawberries -= Globals.RangePrice
		Globals.RangePrice *= 2

func _on_strawberry_shop_purchase_rate():
	if Globals.Strawberries >= Globals.RatePrice:
		$StrawberryTimer.wait_time -= 0.05
		Globals.Strawberries -= Globals.RatePrice
		Globals.RatePrice *= 2

func _on_strawberry_shop_purchase_speed():
	if Globals.Strawberries >= Globals.SpeedPrice:
		$Player.speed += 20
		Globals.Strawberries -= Globals.SpeedPrice
		Globals.SpeedPrice *= 2
