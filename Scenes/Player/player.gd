extends CharacterBody2D

const BASE_SPEED: int = 125
var speed: int = 125
var _theta: float
var _direction: Vector2
@export var rotation_speed: float = TAU * 2

var apple_active: bool = false
var banana_active: bool = false
var pine_active: bool = false
var watermelon_active: bool = false
var current_pickup
var pine_mult: int = 1

func _ready():
	Globals.powerup_collected.connect(_on_collect_area_body_entered)
	Globals.player_quit.connect(_handle_player_quit)

func _process(_delta):
	_direction = Input.get_vector("left", "right", "up", "down")
	velocity = _direction * speed
	move_and_slide()


func _physics_process(delta):
	if _direction:
		$AnimationPlayer.play("walk")
		_theta = wrapf(atan2(_direction.y, _direction.x)- rotation, -PI, PI)
		rotation += clamp(rotation_speed * delta, 0, abs(_theta)) * sign(_theta)
	else:
		$AnimationPlayer.stop()

func _update_player_anim_speed():
	$AnimationPlayer.speed_scale = float(speed) / BASE_SPEED
	print($AnimationPlayer.speed_scale)

func _on_pick_up_range_body_entered(body):
	if "track_player" in body:
		body.track_player()

func _on_collect_area_body_entered(body):
	if "collected" in body:
		$Pickup.play()
		if body.get_parent().name == 'Strawberry':
			Globals.Strawberries += body.gain * pine_mult
		elif body.get_parent().name == 'Grape':
			Globals.Grapes += body.gain * pine_mult
		elif body.name == 'Apple':
			current_pickup = $PickUpRange.scale
			$PickUpRange.scale *= 1.4
			$AppleTimer.start()
		elif body.name == 'Watermelon':
			for timer in get_parent().get_node('Timers').get_children():
				if timer.name != 'CherryTimer':
					timer.wait_time *= 0.5
			$WatermelonTimer.start()
		elif body.name == 'Banana':
			speed += 150
			_update_player_anim_speed()
			$BananaTimer.start()
		elif body.name == 'Pineapple':
			pine_mult = 2
			$PineappleTimer.start()
		
		body.collected()

func _on_apple_timer_timeout():
	$PickUpRange.scale = current_pickup

func _on_watermelon_timer_timeout():
	for timer in get_parent().get_node('Timers').get_children():
		if timer.name != 'CherryTimer':
			timer.wait_time *= 2

func _on_pineapple_timer_timeout():
	pine_mult = 1

func _on_banana_timer_timeout():
	speed -= 150
	_update_player_anim_speed()

func _handle_player_quit():
	for timer in [$AppleTimer, $WatermelonTimer, $PineappleTimer, $BananaTimer]:
		timer.paused = true
	if banana_active:
		speed -= 150
		_update_player_anim_speed()
	if pine_active:
		pine_mult = 1
	if apple_active:
		$PickUpRange.scale = current_pickup
	if watermelon_active:
		for timer in get_parent().get_node('Timers').get_children():
			if timer.name != 'CherryTimer':
				timer.wait_time *= 2
