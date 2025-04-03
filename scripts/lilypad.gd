extends StaticBody2D

@export var speed: float = 100.0
@export var direction: Vector2 = Vector2.RIGHT
@export var max_distance: float = 700.0
var moving := false
var start_position: Vector2
var player = null
func _process(delta):
	if moving:
		player.position += direction * speed * delta
		if player.position.distance_to(start_position) >= max_distance:
			moving = false
func _on_Area2D_body_entered(body):
	if body.is_in_group("player"): 
		body = player
