extends Collectable


func _on_hurt_box_body_entered(body: Node2D) -> void:
	print('a ', body.get_parent().name, ' has exploded!')
	if 'collected' in body:
		body.collected()

func blasted():
	queue_free()
