extends StaticBody2D
func _on_body_entered(body):
	if "Player" in body.name:
		body.take_damage(20)
		
