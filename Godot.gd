extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Po = Vector2(450, 250)
var velocidad :int = 200
var direccio = Vector2(0, 0)
var rotacion = 360/12

# Called when the node enters the scene tree for the first time.
func _ready():
	
	rotation_degrees = 0
	
	position = Po
	scale = Vector2(2,2)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direccio * velocidad * delta
	rotation_degrees += rotacion
	
	if Input.is_action_just_pressed("mou dreta"):
		direccio = Vector2(1, direccio.y)
		
	if Input.is_action_just_released("mou dreta"):
		direccio = Vector2(0, direccio.y)
		
	if Input.is_action_just_pressed("mou esquerra"):
		direccio = Vector2(-1, direccio.y)
		
	if Input.is_action_just_released("mou esquerra"):
		direccio = Vector2(0, direccio.y)
#	if position.x >= 1024-64:
#		velocidad = Vector2(-velocidad.x, velocidad.y)
#
#	if position.x <= 0+64:
#		velocidad = Vector2(-velocidad.x, velocidad.y)
#
#	if position.y >= 600-64:
#		velocidad = Vector2(velocidad.x, -velocidad.y)
#
#	if position.y <= 0+64:
#		velocidad = Vector2(velocidad.x, -velocidad.y)
