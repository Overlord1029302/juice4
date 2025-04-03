extends Node2D



var breakingdone1 = false
var breakingdone2 = false
var breakingdone3 = false
var breakingdone4 = false
var breakingdone5 = false
@export var fragment_scene: PackedScene
func _ready():
	$AnimatedSprite2D.play("zero")
func destroy():
	
	if breakingdone1 == false:
		$AnimatedSprite2D.play("one")
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
			breakingdone1 = true
	
	
	elif breakingdone2 == false and breakingdone1 == true:
		$AnimatedSprite2D.play("two")
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
			breakingdone2 = true
	
	elif breakingdone3 == false and breakingdone2 == true:
		$AnimatedSprite2D.play("three")
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
			breakingdone3 = true
	elif breakingdone4 == false and breakingdone3 == true:
		$AnimatedSprite2D.play("four")
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
			breakingdone4 = true
	elif breakingdone5 == false and breakingdone4 == true:
		var fragment_count = 8
		for i in range(fragment_count):
			var fragment = fragment_scene.instantiate()
			get_parent().add_child(fragment)
			fragment.global_position = global_position
			var angle = randf_range(0, TAU)  
			var force = Vector2.RIGHT.rotated(angle) * randf_range(100, 200)
			fragment.apply_impulse(force)
			breakingdone4 = true
		queue_free()
	
