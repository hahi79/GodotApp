extends Node

const ENEMY_GROUP="enemy"

var enemy_scene =preload("res://enemy.tscn")
var player_bullet_scene =preload("res://bullet.tscn")
var enemy_bullet_scene =preload("res://enemy_bullet.tscn")

var screen_size: Vector2

## 敵の弾を生成
func create_enemy_bullet(pos):
	var bullet=enemy_bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(pos)
## ブレーヤの弾を生成
func create_player_bullet(pos):
	var bullet=player_bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(pos)
## エネミーを生成
func create_enemy(pos):
	var enemy=enemy_scene.instantiate()
	get_tree().root.add_child(enemy)
	enemy.start(pos)
	return enemy
	
## ツリーエントリー時
func _enter_tree():
	screen_size = get_tree().root.get_viewport().get_visible_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

## 秒待ち
func wait_sec(sec):
	await get_tree().create_timer(sec).timeout

####################################
## 追加作成
enum{
	ITEM_SHIELD=0,
	ITEM_MISSILE=1,
}

var item_scene=preload("res://item.tscn")
var n_main:Node2D

## アイテムを生成
func create_item(pos,kind):
	var item=item_scene.instantiate()
	get_tree().root.add_child(item)
	item.start(pos,kind)
	item.get_item.connect(_on_get_item)

## Mainノードを設定
func set_main(main):
	n_main=main
## get_itemシグナル
func _on_get_item(kind):
	if n_main!=null:
		n_main.get_item(kind)	
## シールドアイテム生成できる?
func can_generate_shield_item():
	return n_main.can_generate_shield_item()
# ボーズon/off
func pause(flag:bool):
		get_tree().paused=flag

####################################
## 追加作成2
enum {
	DIR_R,
	DIR_DR,
	DIR_D,
	DIR_DL,
	DIR_L,
	DIR_UL,
	DIR_U,
	DIR_UR,
}
var missile_bullet_scene=preload("res://missile_bullet.tscn")
var missile_defeat_count =0

## ミサイル弾の生成
func create_missile_bullet(pos,dir):
	var missile=missile_bullet_scene.instantiate()
	get_tree().root.add_child(missile)
	missile.start(pos,dir)

func defeat_enemy(enemy):
	missile_defeat_count += 1
	if can_generate_shield_item():
		create_item(enemy.position,Common.ITEM_SHIELD)
	if can_generate_missile_item():
		create_item(enemy.position,Common.ITEM_MISSILE)

func can_generate_missile_item():
	if missile_defeat_count >30:
		missile_defeat_count=0;
		return true
	return false

func is_missile_shot():
	return n_main.is_missile_shot()
