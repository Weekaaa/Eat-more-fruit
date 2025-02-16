extends Collectable

signal drop_fruits(amount)

func _on_hurt_box_body_entered(body: Node2D) -> void:
	if 'collected' in body:
		body.collected()
	elif body.name == 'Player': # Change to be a func in player if needed
		var lost = int(Globals.Strawberries * 0.25)
		drop_fruits.emit(lost)
		Globals.Strawberries -= lost

func blasted(): # Can be changed with finished() signal for particles?
	Globals.entities -= 1
	queue_free()
