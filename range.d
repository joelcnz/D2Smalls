//#woops, it all disapears. ? - What a load of rubbish, good for nothing!
// Found at IDEone
// Have altered it my self, and added wrapper to it (got that from some one too).
import std.stdio;
import std.string;
import std.algorithm;
import std.range;

class wrapper( T ) {
	int index;
    T[] data;
	
    bool empty()
	{
        //return data.length == 0;
		return index == -1 || index == data.length;
    }
	
    void popFront()
	{
       //data = data[1..$]; //#woops, it all disapears. ? - What a load of rubbish, good for nothing!
	   ++index;
    }
	
	void popBack()
	{
		//data = data[ 0 .. $ - 1 ];
		--index;
	}
	
    ref T front() {
        return data[ index ];
    }
	
	ref T back()
	{
		return data[ index ];
	}

/*	
	T[] dup()
	{
		return data.dup;
	}

	int print( int delegate(T) dg ) {
		auto dcopy = data.dup;
		int result;
		while ( ! empty ) {
			result = dg( front );
			popFront;
			if ( result )
				break;
		}
		data = dcopy;
		return result;
	}
*/
} 

void main(){
	auto w = new wrapper!string;

	w.data = split("paper sissors rock");
	/*
	w.print( (string e) {
			writeln(e);
			return 0;
		} );
	w.print( (string e) {
			writeln(e);
			return 0;
		} );
	*/
	writeln("foreach with ranges");
	/*
	foreach (thing; w.dup)
		writeln(thing);
	foreach_reverse (thing; w.dup)
		writeln(thing);

	writeln("Selection");
	foreach (thing; w.dup)
		writeln(thing);
	*/
	w.index = 0;
	foreach ( e; w )
	{
		writeln (e);
	}
	w.index = w.data.length - 1;
	foreach_reverse ( e; w )
	{
		writeln (e);
	}
	
	// filter! - Number has to be 490 or greater
	// iota - starts number at 1, last number printed is 500 and steps +1 at a time
	foreach(v;filter!("a >= 490")(iota(1,501,1))) {
		writeln(v);
	}
	/// backwards in 2 unit steps
	foreach(v; iota(500,490-1,-2)) {
		writeln(v);
	}
	// down to the wire
	foreach(v; iota(0,1+1,1)) {
		writeln(v);
	}
}
