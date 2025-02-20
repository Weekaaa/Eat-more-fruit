extends CharacterBody2D

var speed: int = 150
var _theta: float
var _direction: Vector2
var current_pickup
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
			Globals.Strawberries += body.gain
		elif body.get_parent().name == 'Grape':
			Globals.Grapes += body.gain
		elif body.get_parent().name == 'Apple':
			current_pickup = $PickUpRange.scale
			$PickUpRange.scale *= 1.4
			$AppleTimer.start()
		body.collected()

func _on_apple_timer_timeout():
	$PickUpRange.scale = current_pickup
