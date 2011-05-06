//This file is based from 'The D programming language' book page 399
//#world
/**
Author: Joel Ezra Christensen
Date: July 4, 2010
Discription: Learning threads
*/
import std.concurrency, std.stdio, std.string;
import jec2.all;

const setLocatingNLocation = "
this(int x, int y, string charGfx) {
	super(x, y, charGfx, null);
}";

void main(string[] args) {
	Init(args);

	auto loadingDone = new Done;
	auto bmpm = new BmpMan;

	spawn(&doLoading, bmpm, loadingDone);
	spawn(&play, loadingDone);
	do {
		if (loadingDone())
			bmpm.update, rest(10);
		while (key[KEY_SPACE]) {}
	} while (! key[KEY_ESC]);
}

void doLoading(BmpMan bmpm, Done loadingDone) {
	foreach (i; 0 .. 6)
		bmpm.add(format("sample%02d.tga", i));
	foreach (p; 0 .. 10_000) {
		rest(1);
		if (key[KEY_ESC])
			break;
	}
	loadingDone(true);
}

void play(Done loadingDone) {
	auto wld = new World;
	wld.run(loadingDone);
}

class BmpMan {
	Bmp[] bmps;
	int frame = 0;
	void add(string fileName) {
		bmps ~= new Bmp(fileName);
		bmps[$ - 1].ReSize(SCREEN_W, SCREEN_H);
	}
	void update() {
		blit(bmps[frame](), screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
		frame++;
		if (frame == bmps.length)
			frame = 0;
	}
}

class Done {
	bool _done = false;
	bool opCall() {
		return _done;
	}
	void opCall(bool done) {
		_done = done;
	}
}

final class World {
private:
	Operator[] _ops;
public:
	this() {
		_ops ~= new Bady(0, 0, "<BADY>");
		_ops ~= new Goody(SCREEN_W / 2, 200, "<^>", new Snd("blowup.wav"));
	}
	void run(Done finishedLoading) {
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
			if (key[KEY_ESC] || finishedLoading())
				done = true;
		} while (! done);
	}
}

abstract class Operator {
private:
	int _x, _y;
	string _charGfx;
	bool _remove;
	Snd _sound;
public:
	this(int x, int y, string charGfx, Snd sound) {
		_x = x;
		_y = y;
		_charGfx = charGfx;
		_remove = false;
		_sound = sound;
	}
	int xpos() { return _x; }
	int ypos() { return _y; }
	int width() { return _charGfx.length * 8; }
	bool remove() { return _remove; }
	abstract string type();
	abstract void update(Operator[]);
	void playSound() { _sound.Play; }
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
	mixin(setLocatingNLocation);
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
	mixin(setLocatingNLocation[0 .. $ - 1] ~ `  }`);
	this(int x, int y, string charGfx, Snd snd) {
		super(x, y, charGfx, snd);
		_score = new Score(0, 200 + 8,"");
	}
	override void update(Operator[] ops) {
		wipe;
		if (key[KEY_LEFT] && _x - 10 >= 0)
			_x -= 10;
		if (key[KEY_RIGHT] && _x + width < SCREEN_W)
			_x += 10;
		if (key[KEY_SPACE] && _ballit is null)
			_ballit = new GoodyBallit(_x + 8, _y, "|", _sound);
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
	this(int x, int y, string charGfx, Snd sound) {
		super(x, y, charGfx, sound);
	}
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
	mixin(setLocatingNLocation);
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
