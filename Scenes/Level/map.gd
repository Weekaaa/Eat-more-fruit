extends Node2D

@onready var Strawberry: PackedScene = preload("res://Scenes/Fruits/strawberry.tscn")
@onready var Cherry: PackedScene = preload("res://Scenes/Fruits/cherry.tscn")
@onready var Grape: PackedScene = preload("res://Scenes/Fruits/grape.tscn")
@onready var Apple: PackedScene = preload("res://Scenes/Fruits/apple.tscn")
@onready var Watermelon: PackedScene = preload("res://Scenes/Fruits/watermelon.tscn")
@onready var Pineapple: PackedScene = preload("res://Scenes/Fruits/pineapple.tscn")
@onready var Banana: PackedScene = preload("res://Scenes/Fruits/banana.tscn")
@onready var Ghost: PackedScene = preload("res://Scenes/Player/ghost.tscn")
var last_powerup = null
var max_size: int = 1
var max_spawns: int = 1
var scale_options = [
	{"scale": Vector2(0.1, 0.1), "weight": 87},  # 87% chance (87/100)
	{"scale": Vector2(0.15, 0.15), "weight": 12},  # 12% chance (12/100)
	{"scale": Vector2(0.25, 0.25), "weight": 1}   # 1% chance (1/100)
]
var extra_spawns = [
	{"amount": 1, "weight": 75},
	{"amount": 2, "weight": 18},
	{"amount": 3, "weight": 6},
	{"amount": 4, "weight": 0.9},
	{"amount": 5, "weight": 0.1}
]


func _ready():
	var tween = create_tween()
	tween.tween_property($ColorRect, "modulate", Color(00000000), 1)

func _process(_delta):
	if int(%StrCount.text) != Globals.Strawberries:
		%StrCount.text = Globals.fix_nums(Globals.Strawberries)
	if int(%GrpCount.text) != Globals.Grapes:
		%GrpCount.text = Globals.fix_nums(Globals.Grapes)
	
	if Input.is_action_just_pressed("ui_cancel"):
		%PauseMenu.visible = !%PauseMenu.visible

func update_player_data():
	SaveLoad.load_game()
	max_size = Globals.SizeUpgCount + 1
	max_spawns = Globals.ExtraUpgCount + 1
	for i in range(Globals.SpeedUpgCount):
		$Player.speed += 20
	for i in range(Globals.RangeUpgCount):
		$Player.get_child(3).scale *= 1.1
	for i in range(Globals.GhostsUpgCount):
		$Ghosts.add_child(Ghost.instantiate())
	for i in range(Globals.RateUpgCount):
		%StrawberryTimer.wait_time *= 0.8
	for i in range(Globals.GrateUpgCount):
		%GrapeTimer.wait_time *= 0.9

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
	var base = 2
	fruit.global_position = random_pos
	
	if fruit_name == 'Strawberry': 
		base += traits[1]
		fruit.scale = traits[0]
		$Fruits/Strawberry.add_child(fruit)
	elif fruit_name == 'Grape':
		base += traits[1]
		fruit.scale = traits[0]
		$Fruits/Grape.add_child(fruit)
	elif fruit_name == 'Cherry':
		fruit.connect('drop_fruits', _on_cherry_drop_fruits)
		$Fruits/Cherry.add_child(fruit)
	else: # For any powerup fruits
		$Fruits/Powerup.add_child(fruit)
	
	fruit.gain = pow(base, Globals.GainUpgCount)
	# Special case so that the extra size upgrade works at a certain level
	if Globals.SizeUpgCount == 1 and Globals.GainUpgCount == 0 and traits[1] == 1: 
		fruit.gain += 1
	Globals.entities += 1

#===========================================================#
#--------------------------TIMERS---------------------------#
#===========================================================#

func _on_strawberry_timer_timeout():
	if Globals.entities < 300:
		for i in range(get_random_spawns(max_spawns)):
			_spawn_fruit(Strawberry, 'Strawberry')
			await get_tree().create_timer(0.1).timeout

func _on_cherry_timer_timeout():
	if Globals.entities > 250:
		_spawn_cherries(4)
	elif Globals.entities > 200:
		_spawn_cherries(3)
	elif Globals.entities > 100:
		_spawn_cherries(2)
	elif Globals.entities > 30:
		_spawn_cherries(1)

func _on_grape_timer_timeout():
	if Globals.entities < 300:
		for i in range(get_random_spawns(max_spawns)):
			_spawn_fruit(Grape, 'Grape')
			await get_tree().create_timer(0.1).timeout

func _on_powerup_timer_timeout():
	if Globals.entities < 300:
		var fruit = Globals.power_ups[randi()%len(Globals.power_ups)]
		while last_powerup == fruit and Globals.PowerupsUpgCount != 1:
			fruit = Globals.power_ups[randi()%len(Globals.power_ups)]
		last_powerup = fruit
		
		if fruit == 'Apple':
			_spawn_fruit(Apple, 'Apple')
		elif fruit == 'Watermelon':
			_spawn_fruit(Watermelon, 'Watermelon')
		elif fruit == 'Pineapple':
			_spawn_fruit(Pineapple, 'Pineapple')
		elif fruit == 'Banana':
			_spawn_fruit(Banana, 'Banana')
		
	%PowerupTimer.wait_time = randf_range(10, 24)
	print(%PowerupTimer.wait_time)
	%PowerupTimer.start()

func _spawn_cherries(amount):
	for i in range(amount):
		_spawn_fruit(Cherry, "Cherry")
		await get_tree().create_timer(1.2).timeout

#===========================================================#
#-----------------------SHOP-BUTTONS------------------------#
#===========================================================#

func _on_strawberry_shop_button_pressed():
	$Sounds/Click.play()
	%StrawberryShop.visible = !(%StrawberryShop.visible)
	%GrapeShop.visible = false

func _on_grape_shop_button_pressed():
	$Sounds/Click.play()
	%GrapeShop.visible = !(%GrapeShop.visible)
	%StrawberryShop.visible = false

#===========================================================#
#----------------------UPGRADE-BUTTONS----------------------#
#===========================================================#

func _on_strawberry_shop_purchase_range():
	$Player.get_child(3).scale *= 1.1
	Globals.Strawberries -= Globals.RangePrice
	if Globals.RangeUpgCount < 6:
		Globals.RangePrice *= 1.5
	else:
		Globals.RangePrice *= 2

func _on_strawberry_shop_purchase_rate():
	%StrawberryTimer.wait_time *= 0.8
	Globals.Strawberries -= Globals.RatePrice
	if Globals.RateUpgCount > 8:
		Globals.RatePrice *= 1.5
	elif Globals.RateUpgCount > 1:
		Globals.RatePrice *= 2
	else:
		Globals.RatePrice *= 1.5

func _on_strawberry_shop_purchase_speed():
	$Player.speed += 20
	$Player._update_player_anim_speed()
	Globals.Strawberries -= Globals.SpeedPrice
	if Globals.SpeedUpgCount > 6:
		Globals.SpeedPrice *= 4
	elif Globals.SpeedUpgCount > 3:
		Globals.SpeedPrice *= 2.5
	else:
		Globals.SpeedPrice *= 1.5

func _on_strawberry_shop_purchase_size():
	max_size = Globals.SizeUpgCount + 1
	Globals.Strawberries -= Globals.SizePrice
	Globals.SizePrice *= 20

func _on_strawberry_shop_purchase_grapes():
	%GrapeTimer.start()
	%GrapeShopButton.visible = true
	Globals.Strawberries -= Globals.GrapesPrice

func _on_grape_shop_purchase_extra():
	max_spawns = Globals.ExtraUpgCount + 1
	Globals.Grapes -= Globals.ExtraPrice
	Globals.ExtraPrice *= pow(2, Globals.ExtraUpgCount + 1) * 2

func _on_grape_shop_purchase_gain():
	Globals.Grapes -= Globals.GainPrice
	if Globals.GainUpgCount > 8:
		Globals.GainPrice *= 1.5
	elif Globals.GainUpgCount > 5:
		Globals.GainPrice *= 2
	else:
		Globals.GainPrice *= 2.5

func _on_grape_shop_purchase_ghosts():
	$Ghosts.add_child(Ghost.instantiate())
	Globals.Grapes -= Globals.GhostsPrice
	Globals.GhostsPrice *= 3

func _on_grape_shop_purchase_grate():
	%GrapeTimer.wait_time *= 0.9
	Globals.Grapes -= Globals.GratePrice
	if Globals.GrateUpgCount > 10:
		Globals.GratePrice *= 1.5
	elif Globals.GrateUpgCount > 2:
		Globals.GratePrice *= 2
	else:
		Globals.GratePrice *= 1.5

func _on_grape_shop_purchase_powerups():
	Globals.power_ups.append(Globals.locked_power_ups.pop_back())
	%PowerupTimer.wait_time = randf_range(10, 20)
	%PowerupTimer.start()
	Globals.Grapes -= Globals.PowerupsPrice
	if Globals.PowerupsUpgCount == 1:
		Globals.PowerupsPrice = 2500
	elif Globals.PowerupsUpgCount == 2:
		Globals.PowerupsPrice = 50000
	elif Globals.PowerupsUpgCount == 3:
		Globals.PowerupsPrice = 200000

#===========================================================#

func _on_cherry_drop_fruits(amount):
	%fruit_loss.self_modulate = Color('ffffff')
	%fruit_loss.text = '-' + Globals.fix_nums(amount)
	var tween = create_tween()
	tween.tween_property(%fruit_loss, 'self_modulate', Color('ffffff00'), 2)
	await get_tree().create_timer(2).timeout
	%fruit_loss.text = ''

func _on_pause_menu_quitting():
	SaveLoad.save_game()
