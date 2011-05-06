/**
---
dmd clock.d \jpro\dmd2\windows\import\d\time
---
Had to fix some bugs to get the d.time module working
*/
import std.stdio;
import d.time;

void main()
{
	timing( { steve; } );
	readln;
	timing( { steve; } );
}

void steve()
{
	writeln("Steve - ", clock);
}
