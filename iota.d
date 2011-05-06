import std.stdio;
import std.range;
import core.thread: Thread, dur;

alias dur!"msecs" linePause;

void main() {
	writeln( "Rocket to the moon!" );
	Thread.sleep( linePause ( 1_000 ) );
	foreach( number; iota( /* beginning: */ 10, /* end: */ 0 - 1, /* step: */ -1) ) {
		writeln("Count down: ", number );
		if ( number >0 )
			Thread.sleep( linePause ( 300 ) );
	}
	write( "Blast off!" );
}
