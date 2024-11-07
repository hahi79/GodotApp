extends Node2D


func _ready():
	
	# pone el foco en el boton de nivel1 para seleccionarlo con el teclado
	$Nivel1.grab_focus()


func _on_nivel_1_pressed():
	
	# carga el nivel 1
	get_tree().change_scene_to_file("res://escenas/nivel.tscn")


func _on_exit_pressed():
	
	# cerrar
	get_tree().quit()


func _on_logo_gda_pressed():
	
	# mostrar el panel
	$GDA/PopupPanel.visible = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($GDA/PopupPanel, "position", Vector2i(0, 0), 1)
	$GDA/PopupPanel/Control/VBoxContainer/HBoxContainer3/BotonGDA.grab_focus()


func _on_boton_gda_pressed():
	
	# abrir gamedevargentina.com 
	OS.shell_open("https://gamedevargentina.com")


func _on_boton_volver_pressed():
	
	# cerrar el panel
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($GDA/PopupPanel, "position", Vector2i(-320, 0), 1)
	tween.tween_callback($GDA/PopupPanel.hide)
