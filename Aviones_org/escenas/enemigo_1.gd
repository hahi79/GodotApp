extends Area2D


var velocidad : float = 50.0
var direccion : Vector2 = Vector2.DOWN

signal derribado


func _ready():
	
	derribado.connect($"/root/Nivel".aumenta_puntaje)


func _process(delta: float) -> void:
	
	position += direccion * velocidad * delta
	
	# si sale de la pantalla, destruirlo
	if position.y > GLOBAL.jugador.position.y + GLOBAL.ALTO_PANTALLA:
		# eliminar el enemigo cuando ya no se ve en pantalla
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	
	# el enemigo choca contra algo (bala o jugador)
	if area.is_in_group("balas"):
		derribado.emit()
		
	$AnimatedSprite2D.frame = 1
	desactivar_colisiones()
	$Sombra.hide()
	$AnimatedSprite2D.play("explota")
	$AudioStreamPlayer.play()


func desactivar_colisiones():
	
	# dejar de detectar colisiones mientras hace la animación de explosión
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)


func _on_animated_sprite_2d_animation_finished() -> void:
	
	# al terminar la animación de explosión, eliminar el enemigo
	queue_free()
