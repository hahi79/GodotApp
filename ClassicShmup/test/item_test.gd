extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	Common.set_main(self)
	var pos=Common.screen_size/2
	while true:
		await wait_key()
		var item=randi_range(0,3)
		Common.create_item(pos,item)

# マウス左ボタン押下待ち
func wait_key():
	while true:
		await get_tree().create_timer(0.1).timeout
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			break
	while true:
		await get_tree().create_timer(0.1).timeout
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT)==false:
			break
			
func get_item(item:int):
	print("get_item(%d)" % item)
