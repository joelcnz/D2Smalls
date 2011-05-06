/// And it works! :-D
module recurrence;

import std.stdio;
import std.range;

void main()
{
	auto fib = recurrence!("a[n-1] + a[n-2]")(1, 1);
	
	foreach (e; take(fib, 10)) // <- prints first ten numbers from the sequence
	{ 
		writeln(e); 
	}
	
	writeln( "Or (have to look at the code to see):" );
	foreach ( e; take( recurrence!( "a[ n - 1 ] + a[ n - 2 ]" )( 1, 1 ), 10 ) )
		writeln( e );
}

