extends KinematicBody2D

# Declare member variables here. Examples:
var velocitat_y = 0
var velocitat_x = 200
var salt = 350
var contador_salts = 0
var velocitat = Vector2(0, 0)
var accio = ''
var gravetat = 9.8
var multiplicador_gravetat = 40
var mg = multiplicador_gravetat

var opcio_doble_salt = true
var escalant = false

func _physics_process(delta):
	if is_on_floor():
		accio = ''
		
	velocitat.x = 0
	velocitat.y += gravetat * mg * delta
	
	if Input.is_action_pressed("mou dreta"):
		velocitat.x = velocitat_x
		
	if Input.is_action_pressed("mou esquerra"):
		velocitat.x = -velocitat_x
		
	
	if Input.is_action_pressed("mou dreta") and Input.is_action_pressed("mou esquerra"):
		velocitat.x = 0
	
	if (is_on_wall() or is_on_floor()) and opcio_doble_salt:
		opcio_doble_salt = false
		contador_salts = 0
		
	if not is_on_wall():
		opcio_doble_salt = true
		
	if Input.is_action_pressed("mou amunt"):
		if escalant:
				accio = 'escala'
				velocitat.y = -100
				mg = 0
		else:
			if contador_salts == 0:
				velocitat.y = -salt
			mg = multiplicador_gravetat
			$nuvol_salt.frame = 0
			$nuvol_salt.play('main')
			

			contador_salts += 1
	
	if Input.is_action_pressed("mou avall"):
		if escalant:
			accio = 'escala'
			mg = 0
		else:
			mg = multiplicador_gravetat
			accio = 'ajupeix'
			velocitat.x = 0
			velocitat.y += 50
			
		
	else:
		accio = ''
		
		
	if abs(velocitat.y) >= 500:
		velocitat.y = abs(velocitat.y)/velocitat.y * 500
	velocitat = move_and_slide(velocitat, Vector2.UP)
	
	if is_on_floor() and Input.is_action_pressed("espai"):
		accio = 'llisca'
		
	if is_on_floor() and Input.is_action_pressed("B"):
		accio = 'celebra1'
		
	
	anima(velocitat, accio)
	
func anima(speed: Vector2, action):
	var animacio = $AnimatedSprite
	
	if speed.x > 1: 
		animacio.flip_h = false
		if action == 'llisca':
			animacio.play(action)
		else: animacio.play('camina')
	
	elif speed.x < -1: 
		animacio.flip_h = true
		if action == 'llisca':
			animacio.play(action)
		else: 
			animacio.play('camina')
	
	if not is_on_floor() and abs(velocitat.x) > 1 :
		animacio.play('salta')
		
	if action == 'escala':
		animacio.play('escala')
		
	elif abs(speed.x) < 0.1 or is_on_wall(): 
		animacio.play('quiet')
		if action != '': 
			animacio.play(action)



func _on_Transportador_body_entered(body):
	get_tree().change_scene('res://Pantalla_2.tscn')



func _on_Sierra_body_entered(body):
	if body.name == 'Personatge':
		get_tree().reload_current_scene()
	return

func _on_Area_escala_body_entered(body):
	if body.name == 'Personatge':
		escalant = true
	
