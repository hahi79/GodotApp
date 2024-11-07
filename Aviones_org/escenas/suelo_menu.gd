extends TileMap


var velocidad = 30


func _process(delta):
	
	position.y += velocidad * delta
	
	if position.y >= 1008:
		position.y = 0
