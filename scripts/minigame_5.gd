extends Node2D

var target_scene = "res://scenes/base3.tscn"

func _process(delta):
	change_scene()
func change_scene():
	if Global.slime1 ==true and Global.slime2  == true and Global.slime3 == true and Global.slime4 == true and Global.slime5 == true and Global.slime6==true:
		Global.slime1 = false
		Global.done5 = true
		print("hi")
		TransitionScreen.transition()
		await TransitionScreen.on_transition_finished
		get_tree().change_scene_to_file.bind(target_scene).call_deferred()
