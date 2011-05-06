/**
Author: Joel Ezra Christensen
Date: 5 July, 2010
Comment: Started after midnight or so. Hardly slept that night
*/
import std.stdio, std.string, std.random, std.conv;
import jec2.all;

const SPRITE_CONSTRUCTOR = "
this(string type, int x, int y, string gfx, int[] keys, Snd snd) {
	super(type, x, y, gfx, keys, snd);
   }
";

void main() {
	Init;

	Snd snd = new Snd("blowup.wav");
	Sprite[] sps;
	sps ~= new Shooter("Shooter", 100, 60, "<^>", [KEY_W, KEY_D, KEY_S, KEY_A, KEY_LCONTROL], null);
	sps ~= new Shooter("Shooter", 100, 68, "<^>", [KEY_P, KEY_QUOTE, KEY_SEMICOLON, KEY_L, KEY_RIGHT], null);
	
	foreach (b; 0 .. 10)
		sps ~= new Block("Block", uniform(0, SCREEN_W - 10), uniform(0, SCREEN_H - 10), "X", [], null);
	
	int popUpCounter=0;
	bool popping = true;
	do {
		foreach (piece; sps)
			piece.update(sps);
		for (int p = 0; p < sps.length; p++)
			if (sps[p].type == "Food" && (cast(Food)sps[p]).erase == true) {
				rectfill(screen, cast(int)sps[p].xpos, cast(int)sps[p].ypos,
					cast(int)(sps[p].xpos + sps[p].width), cast(int)(sps[p].ypos + sps[p].height), Colour.black);
				if (p == sps.length - 1)
					sps.length = sps.length - 1;
				else
					sps = sps[0 .. p] ~ sps[p + 1 .. $];
				p--;
			}
		if (popping && popUpCounter-- == 0) {
			popUpCounter = 100, sps ~= new Food("Food", 0, 0, "",[], snd);
			if (sps.length - 2 == 26)
				popping = false;
		}
		rest(1);
	} while (! key[KEY_ESC]);
}

abstract class Sprite {
	static _cid = 0;
	int _id;
	string _type;
	real _x, _y, _dx, _dy;
	string _gfx;
	int[] _keys;
	Snd _snd;
	this(string type, int x, int y, string gfx, int[] keys, Snd snd) {
		_id = _cid++;
		_type = type;
		_x = cast(real)x;
		_y = cast(real)y;
		_dx = _dy = 0;
		_gfx = gfx;
		_keys = keys;
		_snd = snd;
	}
	Sprite update(Sprite[] sps) {
		foreach (s; sps)
			if (s !is this && ! (type == "Food" && s.type == "Shooter") &&
				! (type == "Block" && s.type == "Food") && ! (type == "Food" && s.type == "Block")) {
				void clean() {
					rectfill(screen, cast(int)s.xpos, cast(int)s.ypos, cast(int)(s.xpos + s.width), cast(int)(s.ypos + s.height), 0);
				}
				// side ways
				if (_y + height >= s.ypos && _y <= s.ypos + s.height) {
					// right
					if (_x + width >= s.xpos && _x + width <= s.xpos + width / 2)
						clean, s.xpos = s.xpos + 1;
					// left
					if (_x >= s.xpos + s.width / 2 && _x <= s.xpos + s.width)
						clean, s.xpos = s.xpos - 1;
				}
				if (_x + width >= s.xpos && _x <= s.xpos + s.width) {
					// down
					if (_y + height >= s.ypos && _y + height <= s.ypos + s.height / 2)
						clean, s.ypos = s.ypos + 1;
					// up
					if (_y >= s.ypos + s.height / 2 && _y <= s.ypos + s.height)
						clean, s.ypos = s.ypos - 1;
				}
			}
		if (_x < -width)
			_x = SCREEN_W - width;
		if (_x > SCREEN_W)
			_x = 0;
		if (_y < 0)
			_y = SCREEN_H - height;
		if (_y > SCREEN_H - height)
			_y = 0;

		return this;
	}
	int id() { return _id; }
	real xpos() { return _x; }
	real ypos() { return _y; }
	void xpos(real x0) { _x = x0; }
	void ypos(real y0) { _y = y0; }
	real width() { return cast(real)_gfx.length * 8; }
	real height() { return cast(real)8; }
	string type() { return _type; }
}

class Block : Sprite {
	real _width, _height;
	mixin(SPRITE_CONSTRUCTOR[0 .. $ - 3] ~ "_width = _height = 20; }");
	Sprite update(Sprite[] sps) {
		super.update(sps);
		rectfill(screen, cast(int)_x, cast(int)_y, cast(int)(_x + width - 1), cast(int)(_y + height - 1), Colour.white);
		
		return this;
	}
	real width() { return _width; }
	real height() { return _height; }
}

class Score : Sprite {
	int _score;
	mixin(SPRITE_CONSTRUCTOR[0 .. $ - 3] ~ "_score = 0; }");
	Sprite update(Sprite[] sps) {
		string isScore = format(_gfx ~ " Score: %s", _score);
		rectfill(screen, cast(int)_x, cast(int)_y, cast(int)_x + isScore.length * 8, cast(int)_y + 7, 0);
		textprintf_ex(screen, font, cast(int)_x, cast(int)_y, Colour.amber, -1, toStringz(isScore));
		
		return this;
	}
	void opCall(int points) {
		_score += points;
	}
}

class Food : Sprite {
	bool _erase = false;
	mixin(SPRITE_CONSTRUCTOR[0 .. $ - 3] ~ "reset; }");
	void reset() {
		rectfill(screen, cast(int)_x, cast(int)_y, cast(int)_x + 7, cast(int)_y + 7, 0);
		_x = cast(real)uniform(0, SCREEN_W - 8);
		_y = cast(real)uniform(0, SCREEN_H - 8);
		auto food = "D".dup;
		food[0] = 'A' + uniform(0, 26) & 0xFF;
		_gfx = to!(string)(food);
	}
	Sprite update(Sprite[] sps) {
		textprintf_ex(screen, font, cast(int)_x, cast(int)_y, Colour.yellow, -1, toStringz(_gfx));
		super.update(sps);
		foreach (s; sps)
			if (s.type == "Block" && _x + width >= s.xpos && _x <= s.xpos + s.width && _y + height >= s.ypos && _y <= s.ypos + s.height)
				_erase = true, _snd.Play;
		
		return this;
	}
	bool erase() { return _erase; }
}

class Shooter : Sprite {
	mixin(SPRITE_CONSTRUCTOR[0 .. $ - 3] ~ `_score = new Score("Score", id == 0 ? 0 : 512, SCREEN_H - 8,
		id == 0 ? "Ship1" : "Ship2", [], null); }`);
	const real increment = 0.05;
	Score _score;
	Sprite update(Sprite[] sps) {
		rectfill(screen, cast(int)_x, cast(int)_y, cast(int)_x + _gfx.length * 8, cast(int)_y + 7, 0);
		const dir = [_keys[0], 0, -1,  _keys[1], 1, 0,  _keys[2], 0, 1,  _keys[3], -1, 0];
		const setKey = 0, xdir = 1, ydir = 2;
		foreach (keyDir; 0 .. dir.length) {
			if (key[dir[keyDir + setKey]]) {
				if (_dx == 0)
					_dx = dir[keyDir + xdir] * increment;
				if (_dy == 0)
					_dy = dir[keyDir + ydir] * increment;
				_dx += increment * dir[keyDir + xdir];
				_dy += increment * dir[keyDir + ydir];
				if (_dx < -1f)
					_dx = -1f;
				if (_dx > 1f)
					_dx = 1f;
				if (_dy < -1f)
					_dy = -1f;
				if (_dy > 1f)
					_dy = 1f;
			}
			keyDir += 2; // altamately 3
		}
		if (key[_keys[4]]) {
			_score(+1);
			while(key[_keys[4]]) {}
		}
		if (_dx < 0) _dx += increment * 0.1f;
		if (_dx > 0) _dx -= increment * 0.1f;
		if (_dy < 0) _dy += increment * 0.1f;
		if (_dy > 0) _dy -= increment * 0.1f;
		_x += _dx;
		_y += _dy;
		super.update(sps);
		debug (10)
			writefln("x%s y%s dx%s dy%s", _x, _y, _dx, _dy);
		textprintf_ex(screen, font, cast(int)_x, cast(int)_y, Colour.yellow, -1, toStringz(_gfx));
		_score.update(sps);
		version (Collect) {
			foreach (s; sps)
				if (s.type == "Food" && _x + 3 * 8 >= s.xpos && _x < s.xpos + 7 && _y + 7 >= s.ypos && _y < s.ypos + 7)
					_score(+1), (cast(Food)s).reset;
		}
		return this;
	}
}
