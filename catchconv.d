import std.stdio;
import std.conv;

void main() {
	int error = 18; // trouble with the lens comming out
	try {
		assert( 0, text( error, " don't be alarmed people, this was ment to happen!" ) );
	} catch( Error a ) { //#why can't I put 'catch( AssertError a )' it prints 'AssertError'?
		writeln( text( "Look what I caught! - ", a ) );
	}
}
