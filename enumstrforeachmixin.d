// Forum answer - ajusted by Joel (JEC) - Wednesday 16 Feb 2011
// Didn't realize you could use mixin as a prameter
import std.stdio;

enum FileName : string
{
	file1 = "mud.ext",
	file2 = "dirt.ext"
}

void main()
{
    foreach( a; __traits( allMembers, FileName ) )
	{
        writeln( a, " - ", mixin( "FileName." ~ a ) );
	}
}
