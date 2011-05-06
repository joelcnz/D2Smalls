import tango.io.Stdout;
import tango.stdc.stringz;
import demaljin.all;

void main() {
	DemAlJinInit([]);
	
	const text=[
		" Happy  ",
		"  6th   ",
		"Birthday",
		" Sean!  ",
		" Happy  ",
		"  4th   ",
		"Birthday",
		" Jade!  "];
	BITMAP* block=create_bitmap(text[0].length * 8 - 2, (text.length + 1) * 8);
	foreach (i, t; text)
		textprintf_ex(block, font, 0, i * 8, Colour.amber, 0, toStringz(t));
	textprintf_ex(block, font, 0, text.length * 8 - 8 + 8, Colour.amber, 0, toStringz(text[0]));
	int y=0;
	int zeroPause=8;
	bool done = false;
	BITMAP* stamp=create_bitmap(SCREEN_W / 2, SCREEN_H / 2);
	do {
		clear(stamp);
		rectfill(stamp, 49, 49, 49 + block.w + 1, 49 + 8 + 1, Colour.amber);
		blit(block, stamp, 0, y, 50, 50, block.w, 8);
		stretch_blit(stamp, screen, 0,0, stamp.w,stamp.h, 0,0, stamp.w * 2,stamp.h * 2);
		if (y == block.h - 8 - 	1)
			y=0;
		else
			y++;
		if (zeroPause==0)
			rest(150), zeroPause=8 - 1;
		else
			rest(50), zeroPause--;
		if (key[KEY_ESC])
			done = true;
	} while (! done);
}

/*
class HappyBirthday {
	int x, y, notch, zeroPause;
	char[][] text;
	this(char[][] text) {
		zeroPause=8;
		this.text=[
			" Happy  ",
			"  6th   ",
			"Birthday",
			" Sean!  ",
			" Happy  ",
			"  4th   ",
			"Birthday",
			" Jade!  "];
	}
	void update() {
		if (notch == block.h - 8 - 	1)
			y=0;
		else
			y++;
		if (zeroPause==0)
			rest(150), zeroPause=8 - 1;
		else
			rest(50), zeroPause--;
	}
	void draw(BITMAP* bmp) {
		rectfill(bmp, 49, 49, 49 + block.w + 1, 49 + 8 + 1, Colour.amber);
		blit(block, bmp, 0, y, 50, 50, block.w, 8);
	}
}
*/