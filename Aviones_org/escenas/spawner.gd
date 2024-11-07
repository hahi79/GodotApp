extends Node2D


var enemigo1_scn : PackedScene = load("res://escenas/enemigo_1.tscn")
var enemigo2_scn : PackedScene = load("res://escenas/enemigo_2.tscn")
var enemigo3_scn : PackedScene = load("res://escenas/enemigo_3.tscn")


func _on_timer_timeout() -> void:
	
	if GLOBAL.juego_terminado:
		return
	
	var elige_enemigo : int
	
	# dependiendo del nivel de dificultad, variar el tipo de enemigos
	if GLOBAL.nivel_dificultad <= 3:
		elige_enemigo = randi_range(1, 2)
	else:
		elige_enemigo = randi_range(1, 3)
	
	var nuevo_avion
		
	match elige_enemigo:
		1: 
			nuevo_avion = enemigo1_scn.instantiate()
		2: 
			nuevo_avion = enemigo2_scn.instantiate()
		3: 
			nuevo_avion = enemigo3_scn.instantiate()
		_: 
			print("no existe el avión a instanciar")
			
	nuevo_avion.position.x = randi_range(16, 304)
	nuevo_avion.position.y = %Jugador.position.y - 320
	add_child(nuevo_avion)


func aumenta_dificultad():
	
	if $Timer.wait_time > 0.5:
		$Timer.wait_time -= 0.25
		
	GLOBAL.nivel_dificultad += 1
