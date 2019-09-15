tool
extends KinematicBody2D

export(int , "Blue", "Dark", "Green", "Huge", "Red", "Sand") var bodie = 2 setget set_bodie
export(int, "Blue", "Dark", "Green", "Red", "Sand") var barrel = 0 setget set_barrel

var speed = 100
#Packedscene - Cenas empacotadas. Carrega a cena na memoria.
var pre_bullet = preload("res://cenas/bullet.tscn")
#Declarando uma lista
var bodies = [
	"res://sprites/tank_blue.png",
	"res://sprites/tank_dark.png",
	"res://sprites/tank_green.png",
	"res://sprites/tank_huge.png",
	"res://sprites/tank_red.png",
	"res://sprites/tank_sand.png"
]
	
var barrels = [
	"res://sprites/tankBlue_barrel1.png",
	"res://sprites/tankDark_barrel1.png",
	"res://sprites/tankGreen_barrel1.png",
	"res://sprites/tankRed_barrel2.png",
	"res://sprites/tankSand_barrel1.png"
]

func _ready():
	pass
func _draw():
	$sprite.texture = load(bodies[bodie])
	$barrel/sprite.texture = load(barrels[barrel])
	
func _process(delta):
	var dir_x = 0
	var dir_y = 0
	
	if Engine.editor_hint:
		return
	
	if Input.is_action_pressed("ui_right"):
		dir_x += 1
		
	if Input.is_action_pressed("ui_left"):
		dir_x -= 1

	if Input.is_action_pressed("ui_up"):
		dir_y -= 1
		
	if Input.is_action_pressed("ui_down"):
		dir_y +=1
		
	if Input.is_action_just_pressed("ui_shoot"):
		if get_tree().get_nodes_in_group("cannon_bllets").size() < 6:
			bullet()
	#Faz o anter seguir a direcao do mause.
	look_at(get_global_mouse_position())
		
	translate(Vector2(dir_x,dir_y) * delta * speed)
	
func bullet():
	#Cria uma instacia do bullet
	var bullet = pre_bullet.instance()
	#Coloca a bala na posicao aonde esta o muzle
	bullet.global_position = $barrel/muzle.global_position
	bullet.dir = Vector2(cos(rotation), sin(rotation)).normalized()
	get_parent().add_child(bullet)
	$barrel/AnimationPlayer.play("fire")

func set_bodie(val):
	bodie = val
	if Engine.editor_hint:
		update()

func set_barrel(val):
	barrel = val
	if Engine.editor_hint:
		update()
		
