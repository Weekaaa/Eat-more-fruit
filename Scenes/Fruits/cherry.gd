extends Collectable

signal drop_fruits(amount)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if 'collected' in body:
		body.collected()
	elif body.name == 'Player': # Change to be a func in player if needed
		var straws = int(Globals.Strawberries * 0.25)
		var grapes = int(Globals.Grapes * 0.25)
		var lost = straws + grapes
		drop_fruits.emit(lost)
		Globals.Strawberries -= straws
		Globals.Grapes -= grapes

func blasted(): # Can be changed with finished() signal for particles?
	Globals.entities -= 1
	queue_free()
