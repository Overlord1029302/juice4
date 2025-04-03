extends AnimatedSprite2D


func _process(_delta):
	if Global.done1 == true and Global.done2 == false:
		play("1")
	if Global.done2 == true and Global.done3 == false:
		play("2")
	if Global.done3 == true and Global.done4 == false:
		play("3")
	if Global.done4 == true and Global.done5 == false:
		play("4")
	if Global.done5 == true and Global.done6 == false:
		play("5")
	if Global.done6 == true and Global.done7 == false:
		play("6")
	if Global.done7 == true and Global.done8 == false:
		play("7")
	if Global.done8 == true and Global.done9 == false:
		play("8")
	if Global.done9 == true and Global.done10 == false:
		play("9")
	if Global.done10 == true:
		play("MAX")
