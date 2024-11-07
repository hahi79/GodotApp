# hecho por Alejandro Crapanzano
# gamedevargentina.com


extends Area2D


const CANON_AVION : Vector2 = Vector2(0, 20)
const AVANCE : Vector2 = Vector2(0, -0.5)
const FIN_NIVEL : float = -2800.0
const MARGEN_LATERAL : float = 16.0
var velocidad : float = 70.0
var direccion : Vector2 = Vector2.ZERO
var bala_scene : PackedScene = load("res://escenas/bala.tscn")
var puede_disparar : bool = true

signal juego_terminado
signal nivel_completado


func _process(delta: float) -> void:
	
	# si el juego está terminado salir
	if GLOBAL.juego_terminado:
		return
	
	# resetea la dirección anterior 
	direccion = Vector2.ZERO
	
	 # y chequea las teclas pulsadas para mover el avion del jugador
	if Input.is_action_pressed("ui_up"):
		direccion.y = -0.5
	if Input.is_action_pressed("ui_down"):
		direccion.y = 0.2
	if Input.is_action_pressed("ui_left") and position.x > MARGEN_LATERAL:
		direccion.x = -1
	if Input.is_action_pressed("ui_right") and position.x < GLOBAL.ANCHO_PANTALLA - MARGEN_LATERAL:
		direccion.x = 1
	
	# mueve la posicion del avion, tomando en cuenta la velocidad de avance
	position += (direccion + AVANCE) * velocidad * delta
	
	# si pulsó espacio o enter, dispara
	if Input.is_action_pressed("ui_accept") and puede_disparar:
		# inicia el tiempo de retardo para volver a disparar
		$TimerDisparo.start()
		puede_disparar = false
		dispara()
	
	# se fija si llegó al final del nivel
	if position.y <= FIN_NIVEL:
		puede_disparar = false
		desactivar_colisiones()
		nivel_completado.emit()


func _on_area_entered(area: Area2D) -> void:
	
	# el area del jugador choca contra otra area
	# si es un enemigo, pierde la partida
	if area.is_in_group("enemigos"):
		GLOBAL.juego_terminado = true
		desactivar_colisiones()
		$AnimatedSprite2D.frame = 1
		$Sombra.hide()
		puede_disparar = false
		$AnimatedSprite2D.play("explota")
		$AudioStreamPlayer.play()
		# cuando termina la animación ejecuta _on_animated_sprite_2d_animation_finished


func _on_animated_sprite_2d_animation_finished() -> void:
	
	# al terminar la animacion de explosion
	juego_terminado.emit()


func dispara():
	
	# instancia una bala
	var bala = bala_scene.instantiate()
	bala.global_position = global_position - CANON_AVION
	add_sibling(bala)


func _on_timer_disparo_timeout():
	
	puede_disparar = true


func desactivar_colisiones():
	
	# dejar de detectar colisiones mientras hace la animación de explosión
	set_deferred("monitoring", false)
	set_deferred("monitorable", false)
