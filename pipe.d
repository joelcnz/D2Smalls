/**
	This is copied from the digitalmars learn forum (done by: Stanislav Blinov) 'Reading stdin in Windows 7' Aug 17 '10
*/
//Problem: gets an error at the start with 'type | pipe pipe.d'
// 'pipe < pipe.d' - works fine and should be useful
module pipe;

import std.stdio;

void main(string[] args)
{
	writeln("Pipe Entered..");
	foreach (int i, string line; lines(stdin)) {
		write("-"~line[0..$-1]~"-\r\n");
	}
	writeln("Pipe Exiting..");
}
