from random import shuffle

def printable(card):
	if card == "escoba": return card
	else: return str(card[0])+" de "+card[1]

def options(mano, mesa, esc=0):
	value = {"as": 1, 2: 2, 3: 3, 4: 4, 5: 5, 6: 6, 7: 7, "sota": 8, "caballo": 9, "rey": 10}
	solution = list()
	if type(mano) == tuple:
		mano = [mano]
		esc = len(mesa) + 1
	for i in range(len(mesa)):
		mano.append(mesa.pop(i))
		q = sum([value[i[0]] for i in mano])
		if q < 15:
			solution += options(mano, mesa[i:len(mesa)], esc)
		elif q == 15:
			if len(mano) == esc: solution.append(list(i for i in mano)+["escoba"])
			else: solution.append(list(i for i in mano))
		mesa.insert(i, mano.pop())
	return solution

def createDeck():
	return [(("as", 2, 3, 4, 5, 6, 7, "sota", "caballo", "rey")[i%10], ("oros", "copas", "espadas", "bastos")[i//10]) for i in range(40)]

def deal(fromDeck, toDeck, number):
	q = min(len(fromDeck), number)
	toDeck += fromDeck[-q:]
	del fromDeck[-q:]

def chooseSolution(solutions):
	scores = list()
	for s in solutions:
		count = 0
		for c in s:
			if c == "escoba":
				count += 40
			else:
				count += 1
				if c[0] == 7: count += 10
				if c[1] == "oros": count += 4
		scores.append(count)
	return solutions[scores.index(max(scores))]

def chooseDiscard(player):
	scores = list()
	for c in player:
		count = 0
		if c[0] == 7: count += 10
		if c[1] == "oros": count += 4
		scores.append(count)
	return scores.index(min(scores))

def score(discard):
	s = {"escoba": 0, "sietes": 0, "oros": 0, "sieteoros": 0, "cartas": 0}
	for c in discard:
		if c is "escoba":
			s["escoba"] += 1
		elif c == (7, "oros"):
			s["sieteoros"] += 1
			s["sietes"] += 1
			s["oros"] += 1
			s["cartas"] += 1
		elif c[0] == 7:
			s["sietes"] += 1
			s["cartas"] += 1
		elif c[1] is "oros":
			s["oros"] += 1
			s["cartas"] += 1
		else:
			s["cartas"] += 1
	return s
	
			
if __name__ == "__main__":
	b = createDeck()
	shuffle(b)
	p1, p2, mesa, descarte1, descarte2 = list(), list(), list(), list(), list()

	deal(b, mesa, 4)

	while b or p1:
		if not p1: 
			deal(b, p1, 3)
			deal(b, p2, 3)
		print()
		print("Mesa:", ", ".join([printable(x).capitalize() for x in mesa]))
		print("Tú:", ", ".join([printable(x).capitalize() for x in p1]))
		#print("Oponente:", ", ".join([printable(x).capitalize() for x in p2]))
		print()
		
		solution = list()
		for x in p1: solution += options(x, mesa)
		if not solution:
			mesa.append(p1.pop(chooseDiscard(p1)))
			print("Sueltas una carta:", printable(mesa[-1]).capitalize())
		else:
			solution = chooseSolution(solution)
			print("Eliges solución:", ", ".join([printable(x).capitalize() for x in solution]))
			descarte1 += solution
			p1.remove(solution[0])
			if solution[-1] == "escoba": solution.pop()
			for x in solution[1:]: mesa.remove(x)
		
		solution = list()
		for x in p2: solution += options(x, mesa)
		if not solution:
			mesa.append(p2.pop(chooseDiscard(p2)))
			print("Oponente suelta carta:", printable(mesa[-1]).capitalize())
		else:
			solution = chooseSolution(solution)
			print("Oponente elige solución:", ", ".join([printable(x).capitalize() for x in solution]))
			descarte2 += solution
			p2.remove(solution[0])
			if solution[-1] == "escoba": solution.pop()
			for x in solution[1:]: mesa.remove(x)
	
	p1 = score(descarte1)
	p2 = score(descarte2)

	print(mesa)
	print(p1)
	print(p2)
		
			
				

		
