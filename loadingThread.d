//This file is based from 'The D programming language' book page 399
/**
Author: Joel Ezra Christensen
Date: July 4, 2010
Discription: Learning threads
*/
import std.concurrency, std.stdio, std.string, std.math;
import jec2.all;

const loadingBall = "circlefill(screen, SCREEN_W/2+cast(int)(50*sin(a)), SCREEN_H/2+cast(int)(50*cos(a)), 7, Colour";

void main(string[] args) {
	Init(args);

	auto doneAnimation = new Done;
	auto loadingDone = new Done;
	auto bmpm = new BmpMan;

	spawn(&loadAnimation, doneAnimation); // Animation that plays while you wait
	spawn(&doLoading, bmpm, loadingDone); // Stuff that is loading up that you are waiting for
	do {
		if (loadingDone()) {
			doneAnimation(true);
			bmpm.update, rest(10);
		}
		while (key[KEY_SPACE]) {}
	} while (! key[KEY_ESC]);
}

void doLoading(BmpMan bmpm, Done loadingDone) {
	/// While this is loading the waiting animation animates
	foreach (i; 0 .. 6)
		bmpm.add(format("sample%02d.tga", i));
	loadingDone(true);
}

class BmpMan {
	Bmp[] bmps;
	int frame = 0;
	void add(string fileName) {
		bmps~=new Bmp(fileName);
		bmps[$-1].ReSize(SCREEN_W, SCREEN_H);
	}
	void update() {
		blit(bmps[frame](), screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
		frame++;
		if (frame == bmps.length)
			frame = 0;
	}
}

void loadAnimation(Done done) {
	real x, y, a=0;
	char c = 'A';
	do {
		textprintf_ex(screen, font, SCREEN_W / 2, SCREEN_H / 2, Colour.amber, 0, toStringz(format(c)));
		if (c=='Z')
			c='A';
		else
			c++;
		mixin (loadingBall~".black);");
		a+=0.05;
		mixin (loadingBall~".cyan);");
		rest(10);
		if (key[KEY_ESC])
			done(true);
	} while (! done());
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
