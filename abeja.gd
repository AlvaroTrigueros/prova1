extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var cont = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if 0 < cont and cont <= 3:
		position.y -= 100*delta
		cont += +1*delta
	if 3 < cont and cont <= 5:
		position.y += 100*delta
		cont += 1*delta
	if cont > 5:
		cont = 1

