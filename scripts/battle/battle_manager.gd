extends Node

var player_hp = 50
var enemy_hp = 30

var deck = []
var discard_pile = []
var hand = []
var used_cards = []
var max_mana = 3
var current_mana = 3

func update_ui():
	$"../BottomUI/ManaUI/ManaLabel".text = str(current_mana)
	$"../EnemyArea/EnemyHP".text = "HP : " + str(enemy_hp)
	$"../PlayArea/PlayerHP".text = "HP : " + str(player_hp)
	$"../BottomUI/LeftDeckUI/DeckCountLabel".text = str(deck.size())
	$"../BottomUI/RightDeckUI/DiscardCountLabel".text = str(discard_pile.size())

func _ready():

	deck = [

		preload("res://resources/cards/fire_blast.tres"),
		preload("res://resources/cards/basic_attack.tres"),
		preload("res://resources/cards/ice_blast.tres"),
		preload("res://resources/cards/posion_blast.tres"),
		preload("res://resources/cards/shield.tres"),
		preload("res://resources/cards/wind_blast.tres"),
		preload("res://resources/cards/thunder.tres"),
		preload("res://resources/cards/blind.tres"),
		preload("res://resources/cards/stun.tres"),
		preload("res://resources/cards/sleep.tres")

	]

	draw_starting_hand()

	update_ui()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func draw_starting_hand():

	deck.shuffle()

	hand.clear()

	for i in range(5):

		hand.append(deck.pop_front())

	update_hand_visual()

func draw_one_card():

	if hand.size() >= 5:
		return

	if deck.is_empty():

		deck = discard_pile.duplicate()

		discard_pile.clear()

		deck.shuffle()

	if deck.size() > 0:

		hand.append(deck.pop_front())

	update_hand_visual()

func update_hand_visual():

	var hand_area = $"../BottomUI/HandArea"

	for i in range(hand_area.get_child_count()):

		var card = hand_area.get_child(i)

		if i < hand.size():

			card.visible = true

			card.card_data = hand[i]

			card.update_card()

		else:
			card.visible = false

func _process(delta: float) -> void:
	pass

func _on_end_turn_pressed() -> void:
	end_turn()

func end_turn():

	for card in hand:
		discard_pile.append(card)

	for card in used_cards:
		discard_pile.append(card)

	hand.clear()
	used_cards.clear()

	enemy_turn()

	refill_hand()

	current_mana = max_mana

	update_ui()

func enemy_turn():

	var enemy_damage = 6

	player_hp -= enemy_damage

	check_battle_result()

func refill_hand():

	while hand.size() < 5:

		if deck.is_empty():

			if discard_pile.is_empty():
				break

			deck = discard_pile.duplicate()

			discard_pile.clear()

			deck.shuffle()

		if deck.size() > 0:

			hand.append(deck.pop_front())

	update_hand_visual()

func draw_hand():

	deck.shuffle()

	var hand = deck.slice(0, 5)

	var hand_area = $"../BottomUI/HandArea"

	for i in range(hand.size()):

		var card = hand_area.get_child(i)

		card.card_data = hand[i]

		card.update_card()

func check_battle_result():

	if enemy_hp <= 0:

		enemy_hp = 0

		print("PLAYER WIN")

		battle_win()


	if player_hp <= 0:

		player_hp = 0

		print("PLAYER LOSE")

		battle_lose()
		
func battle_win():
	print("Victory")

func battle_lose():

	print("Game Over")

func discard_card(card_data):

	hand.erase(card_data)

	used_cards.append(card_data)

	update_hand_visual()
