extends Node2D


# Called when the node enters the scene tree for the first time.
func _process(_delta):
		if $AudioStreamPlayer.playing == false:
			$AudioStreamPlayer.play()
