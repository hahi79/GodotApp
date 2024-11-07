extends Area2D

# este avion no se usa en el juego, solo lo hice para las pruebas de suelos_random


func _process(delta):
	
	var direccion = Vector2(0, -1)
	var velocidad = 50
	position += direccion * velocidad * delta
