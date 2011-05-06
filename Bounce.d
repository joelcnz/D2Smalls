//# not sure about this
import std.stdio;
import std.random;
import std.math;
import jec2.all;

void main() {
	Init([]);
	Pic[] pics;
	foreach (p; 0 .. 500)
		pics ~= new Pic;
	BITMAP* stamp = create_bitmap(SCREEN_W, SCREEN_H);
	bool done = false;
	while (! done) {
		clear_bitmap(stamp);
		foreach (p; pics)
			p.update(pics), p.draw(stamp);
		blit(stamp, screen, 0, 0, 0, 0, stamp.w, stamp.h);
//		rest(50);
		if (key[KEY_ESC])
			done = true;
	}
}

struct Point {
	int X, Y;
	void opOpAssign(string op)(Point p) {
		if (op == "+") {
			X += p.X;
			Y += p.Y;
		}
	}
}

struct Texture {
	int Width, Height;
}

class Pic {
	Point SpritePosition;
	Texture MyTexture;
	Point spriteSpeed;
	this() {
		spriteSpeed = Point( uniform(0, 8), uniform(0, 8));
		MyTexture = Texture(14, 12);
		SpritePosition = Point(uniform(0, SCREEN_W - MyTexture.Width), uniform(0, SCREEN_H - MyTexture.Height));
	}
	
	bool inBounds(Pic p) {
		if (SpritePosition.X + MyTexture.Width >= p.SpritePosition.X &&
			SpritePosition.X <= p.SpritePosition.X + p.MyTexture.Width &&
			SpritePosition.Y + MyTexture.Height >= p.SpritePosition.Y &&
			SpritePosition.Y <= p.SpritePosition.Y + p.MyTexture.Height)
			return true;
		return false;
	}
	
	void update(Pic[] picSprites) {
		SpritePosition += spriteSpeed;
		/*
		Problem: Sprites bouncing off nothing
		Started this program in C# XNA
		Solved: need to check both horrozontal(sp) and virtical at the same time
		*/
		foreach (p; picSprites)
			if (p !is this && inBounds(p)) {
				//# not sure about this
				bool hitArea(int ax, int awx, int bx, int bwx) {
					if (ax + awx >= bx &&
						ax < bx + awx)
						return true;
					return false;
				}
				
				if (SpritePosition.X + MyTexture.Width >= p.SpritePosition.X)
					SpritePosition.X = p.SpritePosition.X - MyTexture.Width, spriteSpeed.X = abs(spriteSpeed.X) * -1;
					
				if (SpritePosition.X <= p.SpritePosition.X + p.MyTexture.Width)
					SpritePosition.X = p.SpritePosition.X - p.MyTexture.Width, spriteSpeed.X = abs(spriteSpeed.X) * -1;
					
				if (SpritePosition.Y + MyTexture.Height >= p.SpritePosition.Y)
					SpritePosition.Y = p.SpritePosition.Y - MyTexture.Height, spriteSpeed.Y = abs(spriteSpeed.Y) * -1;
					
				if (SpritePosition.Y <= p.SpritePosition.Y + p.MyTexture.Height)
					SpritePosition.Y = p.SpritePosition.Y + p.MyTexture.Height, spriteSpeed.Y = abs(spriteSpeed.Y) * -1;
			}

		if (SpritePosition.X < 0 || SpritePosition.X + MyTexture.Width > SCREEN_W)
			spriteSpeed.X *= -1;
		if (SpritePosition.Y < 0 || SpritePosition.Y + MyTexture.Height > SCREEN_H)
			spriteSpeed.Y *= -1;
	}
	
	void draw(BITMAP* bmp) {
		rect(bmp, SpritePosition.X, SpritePosition.Y, SpritePosition.X + MyTexture.Width, SpritePosition.Y + MyTexture.Height, Colour.amber);
	}
}
