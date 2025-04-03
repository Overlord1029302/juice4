extends Area2D
@onready var animated_sprite1 = $AnimatedSprite2D
@onready var animated_sprite2 = $AnimatedSprite2D2
@onready var animated_sprite3 = $AnimatedSprite2D3

func _ready():
	animated_sprite1.play("default")
	animated_sprite2.play("default")
	animated_sprite3.play("default")
	if $lava.playing == false:
		$lava.play()
	




func _on_body_entered(body):
	if "Player" in body.name:
		body.take_damage(100)
		body.burn()
	if body.is_in_group("enemies") and !body.is_in_group("enemymaxx"):
		body.take_damage(body.health)
		
