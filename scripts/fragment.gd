extends RigidBody2D

@export var fade_time: float = 1.5  
func _ready():
	var timer = Timer.new()
	timer.wait_time = fade_time
	timer.one_shot = true
	timer.timeout.connect(_fade_out)
	add_child(timer)
	timer.start()

func _fade_out():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.8)
	await tween.finished
	queue_free()
