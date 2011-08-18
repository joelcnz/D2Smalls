//#more

string EnumDefAsString(T)() if (is(T == enum)) {
    string result = "";
    foreach (e; __traits(allMembers, T)) {
        result ~= e ~ " = T." ~ e ~ ",";
    }
    return result;
}

template ExtendEnum(T, string s) if (is(T == enum) && is(typeof({mixin("enum a{"~s~"}");}))) {
    mixin("enum ExtendEnum {" ~
        EnumDefAsString!T() ~ s ~
    "}");
}

unittest {
    enum bar {
        a = 1,
        b = 7,
        c = 19
    }

    import std.typetuple;

    alias ExtendEnum!(bar, q{ // Usage example here.
        d = 25
    }) bar2;

    foreach (i, e; __traits(allMembers, bar2)) {
        static assert( e == TypeTuple!("a", "b", "c", "d")[i] );
    }

    assert( bar2.a == bar.a );
    assert( bar2.b == bar.b );
    assert( bar2.c == bar.c );
    assert( bar2.d == 25 );

    static assert(!is(typeof( ExtendEnum!(int, "a"))));
    static assert(!is(typeof( ExtendEnum!(bar, "25"))));
} 

//#more
import std.stdio;
import std.conv;
import std.traits;

enum Count : int {zero, ten = 10, two = 2, three};

void main() {
	foreach( c; EnumMembers!Count )
		writeln( to!string( c ) ~ ": ", c );
	writeln( "Number of members: ", EnumMembers!Count.length );
	writeln( "Index 2: " ~ to!string( EnumMembers!Count[2] )~": ", EnumMembers!Count[2] );
	auto arr = EnumMembers!Count;
	foreach( c; arr[ 1 .. 3 ] )
		writeln( to!string(c) ~ ": ", c, " >",  );
	
	alias ReturnType!( returnType ) retType;
	writeln( "ReturnType of returnType() function: ", typeid( retType ) );
	
	retType str = "There's a cat in the house!".dup;
	writeln( str );
	writeln( returnType );
}

char[] returnType() {
	return "Turtle".dup;
}
