extends Area2D


var velocidad : float = 200.0
var direccion : Vector2 = Vector2.UP


func _process(delta: float) -> void:
	
	# mover la bala hacia arriba hasta que esté 160 pixels sobre el jugador
	position += direccion * velocidad * delta
	if position.y < GLOBAL.jugador.position.y - 160:
		queue_free()


func _on_area_entered(area):
	
	# si impacta un enemigo, destruir la bala
	if area.is_in_group("enemigos"):
		queue_free()
