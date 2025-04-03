extends Node2D
var playerBody: CharacterBody2D
@onready var player = $Player
func _process(delta):
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.play()
	pass
	
