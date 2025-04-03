extends CharacterBody2D


@export var speed = 200
@export var gravity: int = 200
@export var fall_gravity: int = 300
@export var jump_height = -300

@onready var healthBar = $HealthBar
@onready var dust = preload("res://scenes/dust.tscn")
@export var Jump_Buffer_Time: float = .1
@onready var animation_player = $AnimatedSprite2D
@onready var pickup_area = $PickupArea
var holding_crate = false
var held_crate = null
var is_attacking = false
var is_climbing = false
var hit = false
var death = false
var immortality = false
var is_animating
var maxHealth = 100
var health = 100
var attack_in_progress = false
var attack_cooldown = 0.5
var can_attack = true
var Jump_Buffer:bool = false
var dying = false
@export var attack_damage := 10
@onready var attack_area = $AttackArea
var slowfall: bool = velocity.y > 0 and Input.is_action_pressed("jump")
var onAutoJumpObject = false
@onready var coyote_timer = $CoyoteTimer
var damagin = false
var isgrounded = true
var canDash = true
func _process(_delta):
	if Input.is_action_just_pressed("pickup"):
		print("s") 
		if holding_crate:
			drop_crate()
		else:
			pickup_crate()
	if Input.is_action_just_pressed("ui_attack") and !holding_crate:
		
		attack()
	if Global.plantkill == true:
		Global.plantkill = false
		self.hide()
		set_physics_process(false)
	

		
		
func attack():
		for body in attack_area.get_overlapping_bodies():
			if body.is_in_group("enemies"):
			
				body.take_damage(10)
			elif body.is_in_group("breakable"):
				print("hhh")
				body.destroy()
		

func pickup_crate():

	var crates = pickup_area.get_overlapping_bodies()
	for crate in crates:
		if crate is RigidBody2D:  # Ensure it's a RigidBody2D
			held_crate = crate
			held_crate.visible = false
			Global.cratehide = true
			held_crate.freeze = true
			holding_crate = true
			$AnimatedSprite2D.play("hold_idle")
			return  # Stop checking after picking up one crate
		
func drop_crate():
	Global.cratehide = false
	if held_crate:
		var direction = 1 if !$AnimatedSprite2D.flip_h else -1 
		held_crate.position = global_position
		held_crate.throw_crate(direction,position) 
		held_crate = null
		holding_crate = false
		$AnimatedSprite2D.play("idle")


func _ready():
	healthBar.set_health_bar(health, maxHealth)
	Global.playerBody = self
	$ParallaxBackground/ParallaxLayer/anim.play("default")
	
	
	
	
func gt_gravity(velocity: Vector2):
	if velocity.y <0:
		return gravity
	return fall_gravity
	
func _physics_process(delta): 

	if isgrounded == false and is_on_floor() == true:
		var instance = dust.instantiate()
		instance.global_position = $Marker2D.global_position
		get_parent().add_child(instance)
	isgrounded = is_on_floor()
	if Input.is_action_just_released("ui_jump") and velocity.y <0:
		velocity.y = jump_height / 4
	if not is_on_floor():
	
		velocity.y += gt_gravity(velocity) * delta * (0.75 if slowfall else 1)
	else:
		if Jump_Buffer and !holding_crate:
			velocity.y = jump_height
			$AnimatedSprite2D.play("jump")
			$jump.play()
			Jump_Buffer =false
		if Jump_Buffer and holding_crate:
			velocity.y = jump_height
			$AnimatedSprite2D.play("hold_jump")
			$jump.play()
			Jump_Buffer =false
	velocity.y += gravity * delta 
	horizontal_movement()
	var was_on_floor = is_on_floor()
	
	if was_on_floor && !is_on_floor():
		coyote_timer.start()
	if !is_attacking:
		player_animations() 
	
	if onAutoJumpObject:
		if is_on_floor(): onAutoJumpObject = false
	move_and_slide()
	var direction := Input.get_axis("ui_left","ui_right")
	if Input.is_action_just_pressed("dash") :
		if canDash:
			canDash = false
			$DashTimer.start()
			speed *= 5
			velocity.x = direction * speed
			await get_tree().create_timer(1.0).timeout
			canDash = true
	
func horizontal_movement():
	
		var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		velocity.x = horizontal_input * speed
	



func player_animations():
	# If holding a crate, play "holding" animations
	if holding_crate:
		if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
			$AnimatedSprite2D.flip_h = Input.is_action_pressed("ui_left")
			$AnimatedSprite2D.play("hold_run")
		elif !Input.is_anything_pressed() and !hit:
			$AnimatedSprite2D.play("hold_idle")
		return # Exit function to prevent normal animations from playing

	# If NOT holding a crate, play normal animations
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.flip_h = Input.is_action_pressed("ui_left")
		$AnimatedSprite2D.play("run")
	elif !Input.is_anything_pressed() and !hit:
		$AnimatedSprite2D.play("idle")
func _input(event):
	if event.is_action_pressed("ui_attack") and $AnimatedSprite2D.animation_finished and !dying and !holding_crate:
		is_attacking = true
		$AnimatedSprite2D.play("attack")
		$attack.play()
		if $AnimatedSprite2D.flip_h == false:
			get_node("AttackArea/right").disabled = false
			get_node("AttackArea/left").disabled = true
		if $AnimatedSprite2D.flip_h == true:
			get_node("AttackArea/left").disabled = false
			get_node("AttackArea/right").disabled = true
	
	if event.is_action_pressed("ui_jump") and !is_attacking and !dying and !holding_crate:
		if is_on_floor() || !coyote_timer.is_stopped():
			velocity.y = jump_height
			$AnimatedSprite2D.play("jump")
			$jump.play()
		else:
			Jump_Buffer = true
			get_tree().create_timer(Jump_Buffer_Time).timeout.connect(on_jump_buffer_timeout)
	if event.is_action_pressed("ui_jump") and !is_attacking and !dying and holding_crate:
		if is_on_floor() || !coyote_timer.is_stopped():
			velocity.y = jump_height
			$AnimatedSprite2D.play("hold_jump")
			$jump.play()
		else:
			Jump_Buffer = true
			get_tree().create_timer(Jump_Buffer_Time).timeout.connect(on_jump_buffer_timeout)
	
	if is_climbing == true:
		if Input.is_action_pressed("ui_up"):
			$AnimatedSprite2D.play("climb")
			gravity = 100
			velocity.y = -200
		else:
			gravity = 200
			is_climbing = false
	

		

func take_damage(damage:int):
	if !holding_crate:
		if health > 0 and immortality == false:
			health -= damage
			healthBar.change_health(-damage)
			$AnimatedSprite2D.play("damage")
			damagin = true
			set_physics_process(false)
			immortality = true
		if health <= 0:
		
			$AnimatedSprite2D.play("death2")
			dying = true
	if holding_crate:
		if health > 0 and immortality == false:
			health -= damage
			healthBar.change_health(-damage)
			$AnimatedSprite2D.play("hold_damage")
			damagin = true
			set_physics_process(false)
			immortality = true
		if health <= 0:
		
			$AnimatedSprite2D.play("hold_death2")
			dying = true
func burn():
	if !holding_crate:
		$AnimatedSprite2D.play("death1")
		dying = true
	if holding_crate:
		$AnimatedSprite2D.play("hold_death1")
		dying = true
		
		
	

	

func _on_animated_sprite_2d_animation_finished():
	damagin = false
	
	is_attacking = false
	


	set_physics_process(true)
	immortality = false
	if health <= 0:
		get_tree().reload_current_scene()
	
func on_jump_buffer_timeout()->void:
	Jump_Buffer = false


func _on_dash_timer_timeout() -> void:
	speed = 200
	
	
