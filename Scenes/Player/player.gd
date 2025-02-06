extends CharacterBody2D

var Strawberries: int = 0

var speed: int = 150
var _theta: float
var _direction: Vector2
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
	if "collected" in body:
		if body.get_parent().name == 'Strawberry':
			Strawberries += 1
		body.collected()
		Globals.entities -= 1
		print(Globals.entities)
