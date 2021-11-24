from random import shuffle

def createDeck():
	return [(("as", 2, 3, 4, 5, 6, 7, "sota", "caballo", "rey")[i%10], ("oros", "copas", "espadas", "bastos")[i//10]) for i in range(40)]

def deal(fromDeck, toDeck, number=1):
	q = min(len(fromDeck), number)
	toDeck += fromDeck[-q:]
	del fromDeck[-q:]

def printable(card):
	return str(card[0])+" de "+card[1]

if __name__ == "__main__":
	# Crea el mazo, jugadores y mesa
	value = {"as": 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, "sota": 8, "caballo": 9, "rey": 10}
	b = createDeck()
	shuffle(b)
	p1 = list()
	p2 = list()
	stack1 = list()
	stack2 = list()
	# Puntuaciones
	score1, score2 = 0, 0

	# Se reparten 3 cartas a cada uno
	print("Se reparten 3 cartas\n")
	deal(b, p1, 3)
	deal(b, p2, 3)

	# A jugar!
	while len(p2) > 0:
		deal(p1, stack1)
		deal(p2, stack2)
		print("Jugador 1: %s"%printable(stack1[-1]))
		print("Jugador 2: %s"%printable(stack2[-1]))
		cp = value[stack1[-1][0]] - value[stack2[-1][0]]
		if cp > 0:
			score1 += 1
			print("Gana el 1 (%d:%d)"%(score1, score2))
		elif cp < 0:
			score2 += 1
			print("Gana el 2 (%d:%d)"%(score1, score2))
		else:
			print("Empate (%d:%d)"%(score1, score2))
		print()

	cp = score1 - score2
	if cp > 0:
		print("¡¡El jugador 1 es el ganador!!")
	elif cp < 0:
		print("¡¡El jugador 2 es el ganador!!")
	else:
		print("Empate...")