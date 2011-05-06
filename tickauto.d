/**    
    Arthur: Joel Ezra Christensen
    Date: 26 Feb 2010
*/

//version = AutoRead;
//version = TickOver;

import std.stdio: writeln, write, stdin;
import std.string: lines, stripr, toStringz, split, replace;
import core.thread: Thread, dur;

//alias write fwrite;

void main() {
    version ( AutoRead ) {
    //    auto text = "I went for a walk and fell down a hole."; // Hard coded text
   	 /// Main string holds all the data at once
   	 foreach ( string line; lines( stdin ) ) { // Read in text line by line (to choose text put in the command prompt eg. 'textscoll < journal.txt'
   		 writeln( stripr( line ) );
   		 Thread.sleep( dur!"msecs" ( 100 ) );
   	 }
    }
    
    version ( TickOver ) {
   	 int msecs,
   		 seconds;
   	 foreach( p; 0 .. 10 ) {
   		 if ( p < 5 ) {
   			 writeln( msecs, ") msecs" );
   			 Thread.sleep( dur!"msecs"( 1 ) );
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
