//Started on a bus to Tokoroa from Hamilton July 9, 2010
import std.stdio;
import std.random;
import std.string;
import jec2.all;

void main(string[] args) {
	Init(args);
	
	FlyingText[] fltx;
	fltx.length=200;
	foreach (p; 0 .. fltx.length) {
		fltx[p] = new FlyingText(0, 0, "Bus to Tok");
		FlyingText f = fltx[p];
		do {
			f.setPos(uniform(0, SCREEN_W - f.text.length * 8), uniform(0, SCREEN_H - 8));
		} while (f.hit(fltx) == true);
	}
	BITMAP* stamp=create_bitmap(SCREEN_W, SCREEN_H);
	bool done = false;
	do {
		clear_to_color(stamp, 0x00);
		foreach (b; fltx)
			b.update(fltx);
		foreach (b; fltx)
			b.draw(stamp);
		blit(stamp, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
		rest(1);
		if (key[KEY_ESC])
			done=true;
	} while (! done);
}

class FlyingText {
private:
	string _text;
	real _x, _y, _dx, _dy;
public:
	this(int x, int y, string text) {
		setPos(x, y);
		_text = text;
	}
	void setPos(int x, int y) {
		_x = cast(real)x;
		_y = cast(real)y;
		_dx=_dy=0;
	}
	int xpos() { return cast(int)_x; }
	int ypos() { return cast(int)_y; }
	string text() { return _text; }
	void update(FlyingText[] fltx) {
		_dy += 0.01;
		if (_dy>1) _dy=1;
		real qx = _x, qy = _y;
		_x += _dx;
		_y += _dy;
		if (_y+7>SCREEN_H) {
			_y=qy;
			return;
		}
		foreach (t; fltx)
			if (t != this && hit(t))
				_x = qx, _y = qy;
	}
	void draw(BITMAP* bmp) {
		textprintf_ex(bmp, font, cast(int)_x, cast(int)_y, Colour.amber, -1, toStringz(_text));
	}
	bool hit(FlyingText[] others) {
		foreach (other; others)
			if (other !is null && other != this && hit(other))
				return true;
		return false;
	}
	bool hit(FlyingText o) {
		if (xpos + text.length * 8 >= o.xpos && xpos <= o.xpos + o.text.length * 8 &&
			ypos + 8 >= o.ypos && ypos <= o.ypos + 8)
			return true;
		return false;
	}
}
