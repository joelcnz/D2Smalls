/**
	The map isn't simply one bit per character
*/
import std.string;
import std.c.stdlib;
import std.stdio;
import std.c.time;
import std.conv;
import jec2.all; // my library that uses DAllegro

int xrand()
{
	static int lr = 0;
	lr = rand();
	srand(lr);
	return lr;
}

bool[][] genbt(int w, int h)
{
	auto map = new bool[][](w*2+1, h+1);
	int x,y,v;
	w *= 2;
	char[] s1, s2;
	s1.length = s2.length = w;

	writef("+"); foreach (c; 0 .. w+1) write("-"); writeln("+");
	char[] g; g.length = w + 1;	g[]=' '; writef("|"~g~"|");
	for(y = 0; y < h; y++)
	{
		for(x = 0; x < w;)
		{
			v = (xrand()>>3)&1;
			s1[x] = '#';
			s2[x++] = v ? ' ' : '#';
			s1[x] = v ? '#' : ' ';
			s2[x++] = ' ';
		}
		writef("| %s|\n| %s|\n", s1, s2);
		if (y+1 < h)
			foreach (x, s; s1)
				map[x+1][1+y+y%2] = s == ' ' ? false : true;
		if (y+2 < h)
			foreach (x, s; s2)
				map[x+1][1+y+y%2+1] = s == ' ' ? false : true;
	}
	writef("+"); foreach (c; 0 .. w+1) write("-"); writef("+");
	
	return map;
}

int main(string[] args)
{
	args ~= ["10", "10"];
	Init;
	srand(time(null));
	if(args.length <= 2) return 1;
	bool[][] map = genbt(to!int(args[1]), to!int(args[2]));
	foreach (y, l; map)
		foreach (x, c; l)
			if (c == true)
				rectfill(screen, x*8, y*8, x*8+6, y*8+6, Colour.blue);
	readkey;

	return 0;
}
