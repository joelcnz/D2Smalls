// From ng 26 Feb 2011

import std.stdio;
void main()
{
    int counter;
   
    byte index = 0; // =0 is a dummy

    auto cnter = () {
		if ( ! (counter % 4) )
			writeln();

        writef( "%#.2x, ", index );
        counter++;
	};

    //foreach( int index; ubyte.min .. ubyte.max + 1 )
    for( index = byte.min; index < byte.max; ++index )
		cnter();
	index = byte.max;
	cnter();
}

