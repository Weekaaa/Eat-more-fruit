extends CharacterBody2D
class_name Collectable 

@export var speed = 200
var gain: int = 1
var follow_target = false
var player_position
var target_position
@onready var player = get_parent().get_parent().get_parent().get_node("Player")

func _physics_process(_delta):
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	if follow_target:
		velocity = target_position * speed
		move_and_slide()

func track_player():
	follow_target = true

func collected():
	Globals.entities -= 1
	queue_free()
