extends Node2D

@onready var Strawberry: PackedScene = preload("res://Scenes/Fruits/strawberry.tscn")
@onready var Cherry: PackedScene = preload("res://Scenes/Fruits/cherry.tscn")
@onready var Grape: PackedScene = preload("res://Scenes/Fruits/grape.tscn")
@onready var Ghost: PackedScene = preload("res://Scenes/Player/ghost.tscn")
var max_size: int = 1
var max_spawns: int = 1
var scale_options = [
	{"scale": Vector2(0.1, 0.1), "weight": 87},  # 87% chance (87/100)
	{"scale": Vector2(0.15, 0.15), "weight": 12},  # 12% chance (12/100)
	{"scale": Vector2(0.25, 0.25), "weight": 1}   # 1% chance (1/100)
]
var extra_spawns = [
	{"amount": 1, "weight": 83},
	{"amount": 2, "weight": 12},
	{"amount": 3, "weight": 4},
	{"amount": 4, "weight": 0.9},
	{"amount": 5, "weight": 0.1}
]

func _process(_delta):
	if int(%StrCount.text) != Globals.Strawberries:
		%StrCount.text = Globals.fix_nums(Globals.Strawberries)
	if int(%GrpCount.text) != Globals.Grapes:
		%GrpCount.text = Globals.fix_nums(Globals.Grapes)

func get_random_scale(max_options):
	var total_weight = 0
	for i in range(max_options):
		total_weight += scale_options[i].weight
	
	var random_value = randf_range(0, total_weight)
	var cumulative_weight = 0.0
	for i in range(max_options):
		cumulative_weight += scale_options[i].weight
		if random_value <= cumulative_weight:
			return [scale_options[i].scale, i]

func get_random_spawns(max_options):
	var total_weight = 0
	for i in range(max_options):
		total_weight += extra_spawns[i].weight
	
	var random_value = randf_range(0, total_weight)
	var cumulative_weight = 0.0
	for i in range(max_options):
		cumulative_weight += extra_spawns[i].weight
		if random_value <= cumulative_weight:
			return extra_spawns[i].amount

func _spawn_fruit(fruit_type: PackedScene, fruit_name: String):
	var min_spawn_area = $SpawnLocations/Marker2D.global_position
	var max_spawn_area = $SpawnLocations/Marker2D2.global_position
	var random_pos = Vector2(
		randf_range(min_spawn_area.x, max_spawn_area.x),
		randf_range(min_spawn_area.y, max_spawn_area.y)
	)
	
	var fruit = fruit_type.instantiate()
	var traits = get_random_scale(max_size)
	fruit.global_position = random_pos
	fruit.gain += Globals.GainUpgCount
	
	if fruit_name == 'Strawberry':
		fruit.gain *= (traits[1] + 1) ** 2
		fruit.scale = traits[0]
		$Fruits/Strawberry.add_child(fruit)
	elif fruit_name == 'Grape':
		fruit.gain *= (traits[1] + 1) ** 2
		fruit.scale = traits[0]
		$Fruits/Grape.add_child(fruit)
	elif fruit_name == 'Cherry':
		fruit.connect('drop_fruits', _on_cherry_drop_fruits)
		$Fruits/Cherry.add_child(fruit)
		
	Globals.entities += 1

func _update_gain():
	for fruit in $Fruits/Strawberry.get_children():
		fruit.gain += Globals.GainUpgCount
	for fruit in $Fruits/Grape.get_children():
		fruit.gain += Globals.GainUpgCount

#===========================================================#
#--------------------------TIMERS---------------------------#
#===========================================================#

func _on_strawberry_timer_timeout():
	if Globals.entities < 100:
		for i in range(get_random_spawns(max_spawns)):
			_spawn_fruit(Strawberry, 'Strawberry')
			await get_tree().create_timer(0.1).timeout

func _on_cherry_timer_timeout():
	if Globals.entities > 30:
		_spawn_fruit(Cherry, 'Cherry')

func _on_grape_timer_timeout():
	if Globals.entities < 100:
		for i in range(get_random_spawns(max_spawns)):
			_spawn_fruit(Grape, 'Grape')
			await get_tree().create_timer(0.1).timeout

#===========================================================#
#-----------------------SHOP-BUTTONS------------------------#
#===========================================================#

func _on_strawberry_shop_button_pressed():
	%StrawberryShop.visible = !(%StrawberryShop.visible)
	%GrapeShop.visible = false

func _on_grape_shop_button_pressed():
	%GrapeShop.visible = !(%GrapeShop.visible)
	%StrawberryShop.visible = false

#===========================================================#
#----------------------UPGRADE-BUTTONS----------------------#
#===========================================================#

func _on_strawberry_shop_purchase_range():
	$Player.get_child(2).scale *= 1.1
	Globals.Strawberries -= Globals.RangePrice
	Globals.RangePrice *= 2

func _on_strawberry_shop_purchase_rate():
	%StrawberryTimer.wait_time *= 0.9
	Globals.Strawberries -= Globals.RatePrice
	Globals.RatePrice *= 2

func _on_strawberry_shop_purchase_speed():
	$Player.speed += 20
	Globals.Strawberries -= Globals.SpeedPrice
	Globals.SpeedPrice *= 2

func _on_strawberry_shop_purchase_size():
	max_size += 1
	Globals.Strawberries -= Globals.SizePrice
	Globals.SizePrice *= 10

func _on_grape_shop_purchase_extra():
	max_spawns += 1
	Globals.Grapes -= Globals.ExtraPrice

func _on_grape_shop_purchase_gain():
	_update_gain()
	Globals.Grapes -= Globals.GainPrice

func _on_grape_shop_purchase_ghosts():
	$Ghosts.add_child(Ghost.instantiate())
	Globals.Grapes -= Globals.GhostsPrice

func _on_grape_shop_purchase_grate():
	%GrapeTimer.wait_time *= 0.9
	Globals.Grapes -= Globals.GratePrice

#===========================================================#

func _on_cherry_drop_fruits(amount):
	%fruit_loss.self_modulate = Color('ffffff')
	%fruit_loss.text = '-' + Globals.fix_nums(amount)
	var tween = create_tween()
	tween.tween_property(%fruit_loss, 'self_modulate', Color('ffffff00'), 2)
	await get_tree().create_timer(2).timeout
	%fruit_loss.text = ''
