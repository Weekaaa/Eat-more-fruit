extends CharacterBody2D

@onready var swallow = preload("res://Assets/Ui/Emote/emote1.png")
@onready var hungry = preload("res://Assets/Ui/Emote/emote2.png")
@export var move_speed: float = 60
var wander_radius: Vector2 = Vector2(275, 150) 
var tween: Tween
var in_range = []
var to_follow = []
var last_pos: Vector2 
var following = false

func _ready():
	_pick_new_target()
	$WanderTimer.wait_time = randf_range(3.0, 5.0)
	$WanderTimer.start()
	last_pos = global_position

func _process(_delta):
	if not in_range:
		$Expression.texture = hungry
	
	if not following and not to_follow.is_empty():
		_follow_fruit(to_follow.pop_front())
		%WanderTimer.stop()
		$Expression.texture = swallow

func _pick_new_target():
	var target = Vector2(
		randf_range(-wander_radius.x, wander_radius.x),
		randf_range(-wander_radius.y, wander_radius.y)
	)
	
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(
		self, 
		"global_position", 
		target, 
		global_position.distance_to(target) / move_speed
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	tween.finished.connect(_on_movement_finished)

func _follow_fruit(body):
	following = true
	var target = body.global_position
	if tween:
		tween.kill()
	
	tween = create_tween()
	tween.tween_property(
		self, 
		"global_position", 
		target, 
		global_position.distance_to(target) / move_speed
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	tween.finished.connect(_on_follow_finished.bind(body))

func _on_follow_finished(body):
	if is_instance_valid(body) and "collected" in body:
		_on_collect_area_body_entered(body)
	following = false
	_on_movement_finished()

func _on_movement_finished():
	$WanderTimer.start(randf_range(1.5, 3.5))

func _on_wander_timer_timeout():
	_pick_new_target()

func _on_pick_up_range_body_entered(body):
	to_follow.append(body)
	in_range.append(body)

func _on_pick_up_range_body_exited(body):
	in_range.erase(body)
	to_follow.erase(body)

func _on_collect_area_body_entered(body):
	if "collected" in body:
		$Nom.play()
		following = false
		if body.get_parent().name == 'Strawberry':
			Globals.Strawberries += body.gain
		elif body.get_parent().name == 'Grape':
			Globals.Grapes += body.gain
		else:
			Globals.powerup_collected.emit(body)
		
		body.collected()
