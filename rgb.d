import std.stdio;
import jec2.all;

struct Colours
{
	int amber, yellow;
	void opCall()
	{
		amber = makecol(255,180,0);
		yellow = makecol(255,255,0);
	}
}

void main()
{
	Init(null);
	acquire_screen;
	rectfill(screen, 0,0, 10, 10, Colour.amber);
	rectfill(screen, 10,0, 20, 10, Colour.yellow);
	release_screen;
	readkey;
}