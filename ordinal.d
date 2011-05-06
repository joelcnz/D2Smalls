//From ng
// not work very well. Not sure what it's suppose to do
import std.stdio;

struct Ordinal(T) {
    this(int value) { m_Value = value; }
    this(dchar ch) { m_Value = ch - 'a' + 1; }    // add range checks as appropriate

    alias m_Value this;
    T opCast(T)() if ( is( T == dchar) ) { return m_Value + 'a' - 1; }
	T opCast(T)() if ( is( T == int) ) { return m_Value; }

    // add more operators as appropriate

private:
    int m_Value;
}

void main() {
	auto num = Ordinal!int( 1979 );
	auto chr = Ordinal!dchar( cast(dchar)'j' );
	foreach( a; 0 .. 3 ) {
		writefln( "num = %s, chr = '%s'", cast(int)num + a, cast(dchar)(chr) );
	}
}
