/**
Builder: Joel Ezra Christensen
Date Started: 3/07/'10
*/
import std.stdio;
import std.string: toStringz, format;
import jec2.all;

void main(string[] args) {
	Init(args);

	//Bady location and sprite
	int bx, by;
	string bd;
	bx = 0;
	by = 0;
	bd = "<BADY>";
	
	//Goody
	int gx, gy;
	string gd;
	gx = SCREEN_W / 2;
	gy = 200;
	gd = "<^>";
	
	// Shoot thing
	int sx, sy;
	string sd;
	bool sairboune = false;
	sd = "|";
	
	//Score
	int scx, scy;
	int score;
	scx = 0;
	scy = gy + 8;
	
	bool done = false;
	do {
		wipe(bx, by, bd);
		bx = bx + 3;
		if (bx > SCREEN_W)
			bx = 0, by = by + 10;
		draw(bx, by, bd);
		if (bx > gx && by > gy - 8) {
			draw(80, 50, "Game Over!");
			readkey;
			done = true;
		}
		draw(gx, gy, gd);
		if (sairboune) {
			wipe(sx, sy, " ");
			sy -= 5;
			if (sx >= bx && sx <= bx + bd.length * 8 + 7 &&
				sy >= by && sy <= by + 7)
					wipe(bx, by, bd), bx = 0, score = score + 1, sairboune = false;
			if (sy < 0)
				sairboune = false;
			if (sairboune == true)
				draw(sx, sy, sd);
		}
		if (key[KEY_SPACE] && ! sairboune)
			sx = gx + 8, sy = gy, sairboune = true;
		wipe(scx, scy, format("Score: %s", score));
		draw(scx, scy, format("Score: %s", score));
		rest(10);
		if (key[KEY_ESC])
			done = true;
	} while (! done);
}

void wipe(int x, int y, string txt) {
	rectfill(screen, x, y, x + txt.length * 8, y + 8, 0);
}

void draw(int x, int y, string txt) {
	textprintf_ex(screen, font, x, y, makecol(255,180,0), -1, toStringz(txt));
}
