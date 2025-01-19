extends Area2D

@export var n_anim : AnimatedSprite2D
@export var speed : float =250

var anim_name=[
	"R",
	"DR",
	"D",
	"DL",
	"L",
	"UL",
	"U",
	"UR",
]

var direction :int
var dir_velocity:Vector2
var chase_timer:float

## スタート(位置と向き)
func start(pos,dir):
	position=pos
	set_direction(dir)
	chase_timer=5

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(n_anim!=null)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chase_timer>0:
		chase_timer -= delta
	position += dir_velocity * delta
	
## ターゲット向き(向かうべき方向)を取得
func get_target_dir():
	var enemies=get_tree().get_nodes_in_group(Common.ENEMY_GROUP)
	if enemies.is_empty():
		return direction
	## 一番近い敵に向かう	
	var min_pos:Vector2
	var min_dist:float=10000000000
	for enemy in enemies:
		var dist=position.distance_squared_to(enemy.position)
		if min_dist>dist:
			min_dist=dist
			min_pos=enemy.position
	var angle=position.angle_to_point(min_pos)
	print("angle:%f pos:(%f,%f):min_pos(%f,%f)"%[angle,position.x,position.y,min_pos.x,min_pos.y])
	var target_dir =int((angle+PI) /(2*PI/8) +0.5)
	return target_dir	

## なにかと衝突した
func _on_area_entered(area):
	if area.is_in_group(Common.ENEMY_GROUP):
		area.explode()
		queue_free()
		Common.defeat_enemy(area)

## 画面外にでた
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

## 一定時間ごとに、direction 変化
func _on_chase_timer_timeout():
	if chase_timer>0:
		var target_dir=get_target_dir()
		var diff = target_dir - direction
		if abs(diff)<4:
			if diff!=0:
				add_direction( 1 if diff<0 else -1)
		else:
			add_direction( -1 if diff<0 else 1)
		
		print("target_dir:%d direction:%d" % [target_dir,direction])
		
## 向きに加算
func add_direction(add):
	set_direction( direction + add)
## 向きを設定
func set_direction(dir):
	# direction を正規化(0～7)
	if dir<0 :
		while dir<0:
			dir +=8
	else:
		while dir>=8 :
			dir -=8
	direction=dir
	dir_velocity = Vector2.from_angle(dir*(2*PI/8))*speed
	n_anim.play( anim_name[dir])


