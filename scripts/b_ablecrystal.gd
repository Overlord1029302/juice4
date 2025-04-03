extends Node2D



var breakingdone = false
@export var fragment_scene: PackedScene

func destroy():
	
	if breakingdone == false:
		$AnimatedSprite2D.play("default")
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
	breakingdone = true
