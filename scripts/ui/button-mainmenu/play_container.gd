extends Control

@onready var hover_texture = $HoverTexture

func _ready():
	hover_texture.visible = false

func _on_mouse_entered():
	print("hover masuk")
	$HoverTexture.visible = true
	scale = Vector2(1.05, 1.05)

func _on_mouse_exited():
	print("hover keluar")
	$HoverTexture.visible = false
	scale = Vector2(1, 1)
