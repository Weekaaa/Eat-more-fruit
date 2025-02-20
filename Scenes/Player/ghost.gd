extends CharacterBody2D

@onready var swallow = preload("res://Assets/Ui/Emote/emote1.png")
@onready var hungry = preload("res://Assets/Ui/Emote/emote2.png")
@export var move_speed: float = 40
var wander_radius: Vector2 = Vector2(275, 150) 
var current_tween: Tween
var in_range = []

signal buff_player(type)

func _ready():
	_pick_new_target()
	$WanderTimer.wait_time = randf_range(3.0, 5.0)
	$WanderTimer.start()

func _process(_delta):
	if not in_range:
		$Expression.texture = hungry

func _pick_new_target():
	var target = Vector2(
		randf_range(-wander_radius.x, wander_radius.x),
		randf_range(-wander_radius.y, wander_radius.y)
	)
	
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.tween_property(
		self, 
		"global_position", 
		target, 
		global_position.distance_to(target) / move_speed
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	current_tween.finished.connect(_on_movement_finished)

func _follow_fruit(body):
	var target = body.global_position
	if current_tween:
		current_tween.kill()
	
	current_tween = create_tween()
	current_tween.tween_property(
		self, 
		"global_position", 
		target, 
		global_position.distance_to(target) / move_speed
	).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_SINE)
	
	current_tween.finished.connect(_on_movement_finished)

func _on_movement_finished():
	$WanderTimer.start(randf_range(1.0, 2.0))

func _on_wander_timer_timeout():
	_pick_new_target()

func _on_pick_up_range_body_entered(body):
	%WanderTimer.stop()
	_follow_fruit(body)
	$Expression.texture = swallow
	in_range.append(body)

func _on_pick_up_range_body_exited(body):
	in_range.erase(body)

func _on_collect_area_body_entered(body):
	if "collected" in body:
		if body.get_parent().name == 'Strawberry':
			Globals.Strawberries += body.gain
		elif body.get_parent().name == 'Grape':
			Globals.Grapes += body.gain
		elif body.get_parent().name == 'Apple':
			buff_player.emit('apple')
		body.collected()
