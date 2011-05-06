/**
Builder: Joel Ezra Christensen
Date Started: 3/07/'10
*/
import std.stdio, std.string: toStringz, format;
import jec2.all;

const construct = "
this(int x, int y, string charGfx) {
	super(x, y, charGfx);
}";

void main(string[] args) {
	Init(args);
	auto world = new World;
	world.run;
}

final class World {
private:
	Operator[] _ops;
public:
	this() {
		_ops ~= new Bady(0, 0, "<BADY>");
		_ops ~= new Goody(SCREEN_W / 2, 200, "<^>");
	}
	void run() {
		bool done = false;
		do {
			foreach (o; _ops) {
				o.update(_ops);
			}
			foreach (i; 0 .. _ops.length)
				if (_ops[i].remove) {
					if (i == _ops.length - 1)
						_ops.length = _ops.length - 1;
					else _ops = _ops[0 .. i] ~ _ops[i + 1 .. $];
					i--;
				}
			rest(10);
			if (key[KEY_ESC])
				done = true;
		} while (! done);
	}
}

abstract class Operator {
private:
	int _x, _y;
	string _charGfx;
	bool _remove;
public:
	this(int x, int y, string charGfx = "") {
		_x = x;
		_y = y;
		_charGfx = charGfx;
		_remove = false;
	}
	int xpos() { return _x; }
	int ypos() { return _y; }
	int width() { return _charGfx.length * 8; }
	bool remove() { return _remove; }
	abstract string type();
	abstract void update(Operator[]);
	void wipe(string text = "") {
		if (text == "")
			text = _charGfx;
		rectfill(screen, _x, _y, _x + text.length * 8, _y + 8, 0);
	}
	void draw(string text = "") {
		if (text == "")
			text = _charGfx;
		textprintf_ex(screen, font, _x, _y, makecol(255,180,0), -1, toStringz(text));
	}
}

class Bady : Operator {
	mixin(construct);
	override void update(Operator[] ops) {
		wipe;
		_x += 3;
		if (_x > SCREEN_W)
			_x = 0, _y += 10;
		draw;
	}
	override string type() { return "Bady"; }
	void reset() {
		_x = 0;
	}
}

class Goody : Operator {
private:
	GoodyBallit _ballit;
	Score _score;
public:
	mixin(construct[0 .. $ - 1] ~ `_score = new Score(0, 200 + 8,""); }`);
	override void update(Operator[] ops) {
		wipe;
		if (key[KEY_LEFT] && _x - 10 >= 0)
			_x -= 10;
		if (key[KEY_RIGHT] && _x + width < SCREEN_W)
			_x += 10;
		if (key[KEY_SPACE] && _ballit is null)
			_ballit = new GoodyBallit(_x + 8, _y, "|");
		draw;
		if (_ballit) {
			_ballit.update(ops);
			if (_ballit.remove)
				delete _ballit;
		}
		_score.update(ops);
	}
	void addScore(int increment) { _score.score(+increment); }
	override string type() { return "Goody"; }
}

class GoodyBallit : Operator {
	mixin(construct);
	override void update(Operator[] ops) {
		wipe;
		_y -= 5;
		if (_y < 0)
			_remove = true;
		else {
			foreach (o; ops) {
				if (o.type == "Bady" && 
					_x >= o.xpos && _x <= o.xpos + o.width &&
					_y >= o.ypos && _y <= o.ypos + 8) {
					o.wipe, (cast(Bady)o).reset, _remove = true;
					foreach (so; ops)
						if (so.type == "Goody")
							(cast(Goody)so).addScore(+1);
				}
			}
		}
		if (! remove)
			draw;
	}
	override string type() { return "GoodyBallit"; }
}

class Score : Operator {
private:
	int _score;
public:
	mixin(construct);
	override void update(Operator[] op) {
		wipe(format("Score: %s", _score));
		draw(format("Score: %s", _score));
	}
	override string type() { return "Score"; }
	void score(int increment) {
		_score += increment;
		draw;
	}
}
