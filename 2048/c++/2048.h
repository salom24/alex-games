#ifndef _2048_
#define _2048_

#include <iostream>
#include <cstdlib>
#include <ctime>

class Game2048 {
private:
// Variables
	short numbers[4][4]; // Numero de cada casilla
	bool joined[4][4]; // Si cada casilla se ha fusionado
	bool flag;
	short x, y;
	short freeSpace; // Espacios libres en el tablero
	short changes; // Cambios en el tablero por turno
	int score; // Puntuación
	bool quit; // Si se abandona el juego
	bool winner; // Si se ha ganado
// Functions
	void newNumber();
	bool check();
	void draw();
	void moveRight();
	void moveLeft();
	void moveUp();
	void moveDown();
	void win();
	char getInput();
public:
	Game2048();
	void play();

};

#endif
