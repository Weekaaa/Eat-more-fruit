extends CharacterBody2D

var speed: int = 125
var _theta: float
var _direction: Vector2
var current_pickup
var banana_mult: int = 1
@export var rotation_speed: float = TAU * 2


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


func _on_pick_up_range_body_entered(body):
	if "track_player" in body:
		body.track_player()


func _on_collect_area_body_entered(body):
	if "collected" in body:
		if body.get_parent().name == 'Strawberry':
			Globals.Strawberries += body.gain * banana_mult
		elif body.get_parent().name == 'Grape':
			Globals.Grapes += body.gain * banana_mult
		elif body.name == 'Apple':
			current_pickup = $PickUpRange.scale
			$PickUpRange.scale *= 1.4
			$AppleTimer.start()
		elif body.name == 'Watermelon':
			for timer in get_parent().get_node('Timers').get_children():
				if timer.name != 'CherryTimer':
					timer.wait_time *= 0.5
			$WatermelonTimer.start()
		elif body.name == 'Pineapple':
			speed += 150
			$PineappleTimer.start()
		elif body.name == 'Banana':
			banana_mult = 2
			$BananaTimer.start()
		
		body.collected()

func _on_apple_timer_timeout():
	$PickUpRange.scale = current_pickup

func _on_watermelon_timer_timeout():
	for timer in get_parent().get_node('Timers').get_children():
		if timer.name != 'CherryTimer':
			timer.wait_time *= 2

func _on_pineapple_timer_timeout():
	speed -= 150

func _on_banana_timer_timeout():
	banana_mult = 1
