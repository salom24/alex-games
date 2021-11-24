#include "2048.h"

void Game2048::newNumber() {
	do {
		x = (short)(rand() % 4);
		y = (short)(rand() % 4);
	} while(numbers[x][y] != 0);
	numbers[x][y] = rand() % 100 > 90 ? 4 : 2;
}

bool Game2048::check() {
	bool flag = false;
	freeSpace = 0;
	for(x = 0; x < 4; x++) {
		for(y = 0; y < 4; y++) {
			if(numbers[x][y] == 0) {
				freeSpace += 1;
				flag = true;
			} else if(numbers[x][y] == 2048 && winner == false) win();
		}
	}
	for(x = 0; x < 4; x++) {
		for(y = 0; y < 3; y++) {
			if(numbers[x][y] == numbers[x][y+1])
				flag = true;
		}
	}
	for(x = 0; x < 3; x++) {
		for(y = 0; y < 4; y++) {
			if(numbers[x][y] == numbers[x+1][y])
				flag = true;
		}
	}
	return flag;
}

void Game2048::draw() {
	system("clear");
	std::cout << "--| 2048 |--	 Score: " << score << std::endl;
	std::cout << std::endl;
	std::cout << "Controls: WASD | Quit: Q" << std::endl;
	for(y = 0; y < 4; y++) {
		std::cout << "---------------------------------" << std::endl << "| ";
		for(x = 0; x < 4; x++){
			joined[x][y] = false;
			if(numbers[x][y] != 0)
				std::cout << numbers[x][y];
			std::cout << "\t" << "| ";
		}
		std::cout << std::endl;
	}
	std::cout << "---------------------------------"	<< std::endl;
	changes = 0;
}

void Game2048::moveRight() {
	do {
		flag = false;
		for(y = 0; y < 4; y++) {
			for(x = 3; x > 0; x--) {
				if(numbers[x][y] == 0) {
					if(numbers[x-1][y] != 0) {
						numbers[x][y] = numbers[x-1][y];
						joined[x][y] = joined[x-1][y];
						numbers[x-1][y] = 0;
						joined[x-1][y] = false;
						flag = true;
						changes++;
					}
				} else if(numbers[x][y] == numbers[x-1][y] && joined[x][y] == false && joined[x-1][y] == false) {
					numbers[x][y] = numbers[x][y] + numbers[x][y];
					score += numbers[x][y];
					joined[x][y] = true;
					numbers[x-1][y] = 0;
					joined[x-1][y] = false;
					flag = true;
					changes++;
				}
			}
		}
	} while (flag == true);
};

void Game2048::moveLeft() {
	do {
		flag = false;
		for(y = 0; y < 4; y++) {
			for(x = 0; x < 3; x++) {
				if(numbers[x][y] == 0) {
					if(numbers[x+1][y] != 0) {
						numbers[x][y] = numbers[x+1][y];
						joined[x][y] = joined[x+1][y];
						numbers[x+1][y] = 0;
						joined[x+1][y] = false;
						flag = true;
						changes++;
					}
				} else if(numbers[x][y] == numbers[x+1][y] && joined[x][y] == false && joined[x+1][y] == false) {
					numbers[x][y] = numbers[x][y] + numbers[x][y];
					score += numbers[x][y];
					joined[x][y] = true;
					numbers[x+1][y] = 0;
					joined[x+1][y] = false;
					flag = true;
					changes++;
				}
			}
		}
	} while (flag == true);
};

void Game2048::moveUp() {
	do {
		flag = false;
		for(x = 0; x < 4; x++) {
			for(y = 0; y < 3; y++) {
				if(numbers[x][y] == 0) {
					if(numbers[x][y+1] != 0) {
						numbers[x][y] = numbers[x][y+1];
						joined[x][y] = joined[x][y+1];
						numbers[x][y+1] = 0;
						joined[x][y+1] = false;
						flag = true;
						changes++;
					}
				} else if(numbers[x][y] == numbers[x][y+1] && joined[x][y] == false && joined[x][y+1] == false) {
					numbers[x][y] = numbers[x][y] + numbers[x][y];
					score += numbers[x][y];
					joined[x][y] = true;
					numbers[x][y+1] = 0;
					joined[x][y+1] = false;
					flag = true;
					changes++;
				}
			}
		}
	} while (flag == true);
};

void Game2048::moveDown() {
	do {
		flag = false;
		for(x = 0; x < 4; x++) {
			for(y = 3; y > 0; y--) {
				if(numbers[x][y] == 0) {
					if(numbers[x][y-1] != 0) {
						numbers[x][y] = numbers[x][y-1];
						joined[x][y] = joined[x][y-1];
						numbers[x][y-1] = 0;
						joined[x][y-1] = false;
						flag = true;
						changes++;
					}
				} else if(numbers[x][y] == numbers[x][y-1] && joined[x][y] == false && joined[x][y-1] == false) {
					numbers[x][y] = numbers[x][y] + numbers[x][y];
					score += numbers[x][y];
					joined[x][y] = true;
					numbers[x][y-1] = 0;
					joined[x][y-1] = false;
					flag = true;
					changes++;
				}
			}
		}
	} while (flag == true);
};

void Game2048::win() {
	short p = changes;
	draw();
	changes = p;
	winner = true;
	std::cout << "######	You won!!  ######" << std::endl;
	std::cout << "Do you want to continue? (y/n)" << std::endl;
	switch(getInput()) {
		case 'n':
		case 'N':
			quit = true;
			break;
		default:
			break;
	}
}

char Game2048::getInput() {
	char a = std::cin.get();
	//std::cin.ignore(INT_MAX,'\n');
	return a;
}

Game2048::Game2048() {
	srand(time(NULL));
	score = 0;
	winner = false;
	for (x = 0; x < 4; x++) {
		for (y = 0; y < 4; y++) {
			numbers[x][y] = 0;
			joined[x][y] = false;
		}
	}
}

void Game2048::play() {
	newNumber();
	newNumber();
	draw();
	quit = !check();
	while(quit == false) {
		switch (getInput()) {
			case 'a':
			case 'A':
				moveLeft();
				break;
			case 'd':
			case 'D':
				moveRight();
				break;
			case 'w':
			case 'W':
				moveUp();
				break;
			case 's':
			case 'S':
				moveDown();
				break;
			case 'q':
			case 'Q':
				quit = true;
				break;
			default:
				break;
		}
		if(freeSpace != 0 && changes != 0)
			newNumber();
		quit = !check() || quit;
		draw();
	}
}

int main(int argc, char * argv[]) {
	Game2048 theGame;
	theGame.play();
	return 0;
}
