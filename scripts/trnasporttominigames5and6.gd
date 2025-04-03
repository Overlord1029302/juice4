extends Area2D
@onready var anim_sprite = $AnimatedSprite2D
@export var target_scene: String 

func _ready():
	connect("body_entered", _on_body_entered)
	anim_sprite.play("default")
	 
	

	

func _on_body_entered(body):
	if body.is_in_group("player"):  
			call_deferred("change_scene")
func change_scene():
	print(Global.done1)
	if Global.done5 == false:
		target_scene = "res://scenes/minigame5.tscn"
	if Global.done5 == true and Global.done6 == false:
		target_scene = "res://scenes/minigame6.tscn"
	if Global.done6 == true and Global.done7 == false:
		target_scene = "res://scenes/minigame7.tscn"
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file(target_scene)
