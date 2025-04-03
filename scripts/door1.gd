extends StaticBody2D
var rise_speed = 15
var max_height = -10000

func _process(delta):
	
	if Global.door1open == true:
		print("helloagain")
		if position.y > max_height:
			position.y -= rise_speed * delta  
 
