extends RigidBody2D
var tutdone = false
@export var throw_force: Vector2 = Vector2(200, -300) 
func _ready():
	freeze = false 
	$Epick.hide()

func _process(delta):
	if Global.cratehide == true:
		$CollisionShape2D.disabled = true

func throw_crate(direction: int,position1):
	PhysicsServer2D.body_set_state(
	get_rid(),
	PhysicsServer2D.BODY_STATE_TRANSFORM,
	Transform2D.IDENTITY.translated(position1)
	)
	freeze = false
	visible = true
	$CollisionShape2D.disabled = false
	position += Vector2(10 * direction, -10)
	apply_impulse(throw_force * direction)


func _on_area_2d_body_entered(body):
	
	if body.is_in_group("player") and !tutdone:
		$Epick.show()
		$AnimationPlayer.play("cratetut")
		tutdone = true
