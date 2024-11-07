# hecho por Alejandro Crapanzano
# gamedevargentina.com


extends Sprite2D


var velocidad : float = 0.3
var contador : float = 0.0


func _process(delta):
	
	contador += delta
	position.x += sin(contador) * velocidad
	
