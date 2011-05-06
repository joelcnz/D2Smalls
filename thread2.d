//This file is based from 'The D programming language' book page 399
/**
Author: Joel Ezra Christensen
Date: July 4, 2010
Discription: Learning threads
*/
import std.concurrency, std.stdio, std.string;
import jec2.all;

const HOLD = "while(key[KEY_SPACE]) {}";
const ARROW1 = 0, ARROW2 = 1;

void main(string[] args) {
	Init(args);

	Arrow[] arrows;
	arrows ~= new Arrow(0, 50, ">==>", 10, KEY_LCONTROL);
	arrows ~= new Arrow(0, 100, ">>--->", 11, KEY_RIGHT);

	// spawn two arrows
	foreach (arrowIndex; 0 .. 2)
		spawn(&fly, arrows[arrowIndex]);
	do {
		if (key[KEY_1])
			arrows[ARROW1].move(0);
		if (key[KEY_2])
			arrows[ARROW2].move(0);
	} while (! key[KEY_ESC]);
}

void fly(Arrow arrow) {
	do {
		arrow.update;
		rest(arrow.pauseTime);
		mixin(HOLD);
	} while (! key[KEY_ESC]);
}

class Arrow {
private:
	int _x, _y;
	string _sprite;
	int _pauseTime;
	int _burstKey;
public:
	this(int x, int y, string sprite, int pause, int burstKey) {
		_x = x;
		_y = y;
		_sprite = sprite;
		_pauseTime = pause;
		_burstKey = burstKey;
	}
	int pauseTime() { return _pauseTime; }
	void move(int newPos) {
		clean;
		_x = newPos;
	}
	void clean(int x = -1) {
		if (x != -1)
			x = 0;
		else
			x = _x;
		rectfill(screen, x, _y, x + _sprite.length * 8, _y + 7, 0);
	}
	void update() {
		move(_x + 1);
		if (_x > SCREEN_W)
			_x = 0;
		textprintf_ex(screen, font, _x, _y, Colour.amber, -1, toStringz(_sprite));
		if (_x + _sprite.length * 8 >= SCREEN_W)
			clean(0),textprintf_ex(screen, font, _x - SCREEN_W, _y, Colour.amber, -1, toStringz(_sprite));
	}
}
