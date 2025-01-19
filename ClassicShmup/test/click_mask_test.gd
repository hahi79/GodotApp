extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	if false:
		create_click_mask()
		
func create_click_mask():
	var bm=BitMap.new()
	bm.create(Vector2(200,200))
	for y in range(200):
		var dy=y-100
		for x in range(200):
			var dx=x-100
			var bit:bool= (dx*dx+dy*dy<10000)
			bm.set_bit(x,y,bit)
	var path="res://test/ClickMask.tres"
	ResourceSaver.save(bm,path);	
	print("write to %s" % path)

func _on_texture_button_pressed():
	print("pressed")
