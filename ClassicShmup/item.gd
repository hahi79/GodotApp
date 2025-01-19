extends Area2D

signal get_item

@export var n_sprite:Sprite2D
@export var speed:float=40

var item_kind:int


func start(pos,item):
	position=pos
	item_kind=item
	n_sprite.frame=item	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.y += speed*delta

## 画面外にでた	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

## なにかに衝突した
func _on_area_entered(area):
	if area.name=="Player":
		get_item.emit(item_kind)
		queue_free()
