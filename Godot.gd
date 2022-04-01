extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Po = Vector2(450, 250)
var velocidad :int = 200
var direccio = Vector2(0, 0)
var rotacion = 0
var dimensions = Vector2(2, 2)
var dimensions_pixels = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	rotation_degrees = 0
	
	position = Po
	scale = dimensions
	
	dimensions_pixels.x = $Godot.texture.get_width()*dimensions.x
	dimensions_pixels.y = $Godot.texture.get_height()*dimensions.y
	print(dimensions_pixels)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_pressed("espai"):
		rotacion += 1
		
		dimensions.x += 0.01
		dimensions_pixels.x = $Godot.texture.get_width()*dimensions.x
		
		dimensions.y += 0.01
		dimensions_pixels.y = $Godot.texture.get_height()*dimensions.y
		
	scale = dimensions
	rotation_degrees += rotacion
	
	if Input.is_action_just_pressed("mou dreta"):
		direccio = Vector2(1, direccio.y)
		
	if Input.is_action_just_released("mou dreta"):
		if direccio.x > 0:
			direccio = Vector2(0, direccio.y)
		pass
		
	if Input.is_action_just_pressed("mou esquerra"):
		direccio = Vector2(-1, direccio.y)
		
	if Input.is_action_just_released("mou esquerra"):
		if direccio.x < 0:
			direccio = Vector2(0, direccio.y)
		pass
		
	if Input.is_action_just_pressed("mou avall"):
		direccio = Vector2(direccio.x, 1)
		
	if Input.is_action_just_released("mou avall"):
		if direccio.y > 0:
			direccio = Vector2(direccio.x, 0)
		pass
		
	if Input.is_action_just_pressed("mou amunt"):
		direccio = Vector2(direccio.x, -1)
		
	if Input.is_action_just_released("mou amunt"):
		if direccio.y < 0:
			direccio = Vector2(direccio.x, 0)
		pass
		
	position += direccio.normalized() * velocidad * delta
	
	if position.x >= 1024-dimensions_pixels.x/2:
		position.x = 1024-dimensions_pixels.x/2

	if position.x <= 0+dimensions_pixels.x/2:
		position.x = 0+dimensions_pixels.x/2

	if position.y >= 600-dimensions_pixels.y /2:
		position.y = 600-dimensions_pixels.y /2
		
	if position.y <= 0+dimensions_pixels.y/2:
		position.y = 0+dimensions_pixels.y/2


func _on_Area2D_area_entered(area):
	if modulate == Color(1,1,1):
		modulate = Color(1, 0, 0)
	elif modulate == Color(1,0,0):
		modulate = Color(1, 1, 1)
