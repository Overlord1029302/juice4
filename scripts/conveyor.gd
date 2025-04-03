extends StaticBody2D

@export var speed: float = 100.0  
@export var direction: Vector2 = Vector2.RIGHT  
@export var max_distance: float = 300.0  

var players_on_belt := {}
func _ready():
	$AnimatedSprite2D.play("default")

func _process(delta):
	if Global.changedir == true:
		if direction == Vector2.RIGHT:
			direction = Vector2.LEFT
		elif direction == Vector2.LEFT:
			direction = Vector2.RIGHT
		print("done")
	Global.changedir = false
	for player in players_on_belt.keys():
		var data = players_on_belt[player]
		if data["distance_moved"] < max_distance:
			player.position += direction * speed * delta
			data["distance_moved"] += speed * delta
		else:
			players_on_belt.erase(player)  
	

func _on_body_entered(body):
	if body.is_in_group("player"):
		players_on_belt[body] = {"distance_moved": 0}  

func _on_body_exited(body):
	if body in players_on_belt:
		players_on_belt.erase(body)  
