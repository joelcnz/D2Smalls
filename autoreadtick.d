/**    
    Arthur: Joel Ezra Christensen
    Date: 26 Feb 2010
*/

//version = TickOver;
version = AutoRead;

import std.stdio: writeln, write, stdin;
import std.string: lines, stripr, toStringz, split, replace;
import core.thread: Thread, dur;

alias dur!"msecs" linePause;

void main() {
    version ( AutoRead ) {
		string[] strLines;

		// Main string holds all the data at once
		auto content = lines( stdin );
		foreach ( string line; content ) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
			strLines ~= stripr( line );
		}
		
		// Go round and round
		for( int i = 0; ; ) {
			writeln( strLines[ i ] );
			Thread.sleep( linePause ( 100 ) );
			if ( i + 1 == strLines.length )
				i = 0;
			else
				++i;
		}
    }
    
    version ( TickOver ) {
   	 int msecs,
   		 seconds;
   	 foreach( p; 0 .. 10 ) {
   		 if ( p < 5 ) {
   			 writeln( msecs, ") msecs" );
   			 Thread.sleep( dur!"msecs"( 10 ) );
   			 ++msecs;
   		 }
   		 else {
   			 writeln( seconds, ") seconds" );
   			 if ( p < 9 )
   				 Thread.sleep( dur!"seconds"( 1 ) );
   			 ++seconds;
   		 }
   	 }
    }
}
