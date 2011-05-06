/// From out of 'The D Progamming Language' book page 83 - but added to it a bit
import std.stdio;

void main() {}

uint bitSet(uint value)
{
	uint result;
	for (; value; ++result)
	{
		value &= value - 1;
	}
	return result;
}

unittest
{
	assert ( bitSet(10) == 2 );
	assert ( bitSet(0) == 0 );
	assert ( bitSet(255) == 8 );
}

import std.conv;

string makeHammingWeightsTable(string name, uint max = 255)
{
	string result =  "immutable ubyte[" ~ to!string( max + 1 ) ~ "] "
		~ name ~ " = [ ";
	foreach ( b; 0 .. max + 1 )
	{
		result ~= to!string( bitSet( b ) ) ~ ", ";
	}
	return result ~ "];";
}

unittest
{
	mixin ( makeHammingWeightsTable( "hwTable" ) );
	writeln(makeHammingWeightsTable( "hwTable" ));
	assert ( hwTable[10] == 2 );
	writeln("hwTable[10] - ", hwTable[10]);
	assert ( hwTable[0] == 0 );
	writeln("hwTable[0] - ", hwTable[0]);
	assert ( hwTable[255] == 8 );
	writeln("hwTable[255] - ", hwTable[255]);
}
