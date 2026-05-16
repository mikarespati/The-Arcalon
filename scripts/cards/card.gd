extends TextureButton

@export var mana_cost : int = 1
@export var damage : int = 5
@export var card_data : CardData

var default_position
var default_scale

func _ready():
	default_position = position
	default_scale = scale


func _on_mouse_entered():
	scale = Vector2(0.6, 0.6)

	position = Vector2(
		default_position.x,
		default_position.y - 180
	)

	z_index = 100


func _on_mouse_exited():
	scale = default_scale
	position = default_position
	z_index = 0

func _pressed():

	var battle_manager = get_tree().get_first_node_in_group("battle_manager")

	if battle_manager.current_mana >= mana_cost:
		battle_manager.current_mana -= mana_cost
		battle_manager.enemy_hp -= damage
		battle_manager.animate_enemy_hp()
		battle_manager.discard_card(card_data)
		battle_manager.update_ui()
		battle_manager.check_battle_result()

func update_card():

	$NameLabel.text = card_data.card_name

	$CostContainer/CostLabel.text = str(card_data.mana_cost)

	$DescriptionLabel.text = card_data.description

	$Artwork.texture = card_data.artwork

	mana_cost = card_data.mana_cost
	damage = card_data.damage
