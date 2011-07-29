import std.stdio, std.string;
import std.traits: EnumMembers;

void main() {
	enum Command : char {HELP='h'};
	if ( Command.HELP == 'h')
		write("It is!");
	// Not as good as C#
	enum Num {zero, one};
	Num num = Num.zero;
	write( newline ~ Num.zero.stringof);
	write( newline ~ num.stringof ~ newline );
	
	enum Words : string {
		house = "cat",
		dog = "kennel"
	}
	writeln( "Words: ", Words.house, ' ', Words.dog );
	
	enum Letters : char { h1 ='#', a = 'a', b = 'b', c = 'c', h2 = '#' };
	foreach( l; EnumMembers!Letters[ 1 .. 4 ] )
		write( l );
}
