extends Area2D

var dir = Vector2(0, -1) setget set_dir
var vel = 250

func _ready():
	pass # Replace with function body.

func _process(delta):
	#Controlando a velocidade da bala
	translate(dir * vel * delta)
	pass

#Quando a bala sair da tela deve limpar a bala da memoraia
func _on_notifier_screen_exited():
	queue_free()
	
#Funcao responsal pela posicao da bala.
func set_dir(val):
	dir = val
	rotation = dir.angle()
	pass
