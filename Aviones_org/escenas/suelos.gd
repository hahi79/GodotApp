extends Node2D


var tilemap1_scn = load("res://escenas/tile_map1.tscn")
var tilemap2_scn = load("res://escenas/tile_map2.tscn")
var t = 0

func _ready():
	
	pass
	
func _process(delta):
	
	if int(get_parent().get_node("Avion").position.y) % 240 == 0 or int(get_parent().get_node("Avion").position.y) == 198:
	
		var r = randi_range(1, 2)
		var t2
		if r == 1:
			t2 = tilemap1_scn.instantiate()
		else:
			t2 = tilemap2_scn.instantiate()
		add_child(t2)
		t -= 240
		t2.position.y = t 
