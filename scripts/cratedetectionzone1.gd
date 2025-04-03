extends Area2D




func _on_body_entered(body):
	
	if body is RigidBody2D:
		
		Global.door1open = true
		
