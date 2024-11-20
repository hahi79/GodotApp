extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	while true:
		await wait_key()
		var x=randi_range(20,320)
		var pos=Vector2(x,0)
		var id=randi_range(0,3)
		id=3
		Game.create_enemy(id,pos,self)

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
	pass # Replace with function body.
