extends Control

var can_press = false

func _ready():
	$AnimationPlayer.play("fade")

func _on_animation_player_animation_finished(anim_name):
	can_press = true

func _input(event):
	if can_press and event.is_pressed():
		get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
