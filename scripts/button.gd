extends Node2D


var redtoblue = true
var bluetored = false


func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.changedir = true
		Global.changedir2 = true
		Global.changedir3 = true
		if redtoblue == true:
			$AnimatedSprite2D.play("redtoblue")
			redtoblue = false
			bluetored = true
			
		elif bluetored == true:
			$AnimatedSprite2D.play("bluetored")
			bluetored = false
			redtoblue = true
			
