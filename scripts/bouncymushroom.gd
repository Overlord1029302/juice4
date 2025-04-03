extends StaticBody2D


@export var jumpHeight = 400
@export var jumpDistance = 1000000000000
@export var flipH = false

func _ready():
	$AnimatedSprite2D.flip_h = flipH
	


func _on_area_2d_body_entered(body: Node2D) -> void:
		var jumpDirection = -1 if $AnimatedSprite2D.flip_h else 1
		
		body.velocity = Vector2(jumpDistance * -jumpDirection, -jumpHeight)
		body.onAutoJumpObject = true
