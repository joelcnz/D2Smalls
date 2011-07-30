// last edit 
import std.stdio: writefln, writeln;
import std.c.string: strlen;
import std.conv: to;

//Just came into my head, then left, then came back, and it is, how do you use 'static if'
void main() {
	auto str="Hello, World!"; // string
	auto chr="Hello, World!"c; // char[]
	auto chc="Hello, World!".ptr; // char*
	auto aut="Hello, World"; // uses 'string' - immutable(char)[]

	writefln("%s=%s\n%s=%s\n%s=%s\n- %s=%s(%s)",
		str.stringof, str, chr.stringof, chr, chc.stringof, chc[0..strlen(chc)],
		aut.stringof, aut, aut.mangleof );

	if ( is(typeof(aut):string) )
		writefln("is( typeof( aut ) : string ) - returns true");
	if ( is(typeof(aut):char[]) )
		writefln("is(aut:char[])");
	if ( is(typeof(aut):char*) )
		writefln("is(aut:char*)");
	//Or just puit...
	writeln( "What type is aut: ", typeid( aut ) );

	auto t = new Test( "feet" );
	static if ( is(typeof( t ) == Test) ) {
		auto result = "Yay, worked";
	}
	else {
		auto result = "Work, it did not!";
	}
	writeln( result ); // notice, result is still in scope
	writeln( t );
	t.text(to!string(t)) ~= "@@@";
	writeln( t );
}

//Hey! What's this class for?
class Test {
	private string m_text;
	
	this( string text0 ) {
		text( text0 ) = text0;
	}
	
	ref auto text( string tx ) {
		if ( tx.length >4 )
			m_text = m_text[ 0 .. 4 ];
		return m_text;
	}
	
	override string toString() {
		return text( m_text );
	}
}
