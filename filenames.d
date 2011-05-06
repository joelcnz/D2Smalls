/**
	Not working: has quotes in it and the replace fails
*/
import std.stdio;
import std.file;
import std.string;

/**
 * Egs. 1) filenames "." "%s "
 * 	Or. 2) 	filenames "allegro5\." "copy %s \jpro\dmd2\windows\include\dallegro5\" -- maybe not \
 * 			(flattern dir structor)
			can just put:
			copy dallegro5\*.d \jpro\dmd2\windows\include\dallegro5\
			copy dallegro5\internal\*.d \jpro\dmd2\windows\include\dallegro5\internal\
  	Or.
 */
void main( string[] args ) {

	string replace( string name ) {
		int index = name.indexOf( `.\` );
		
		if ( index != -1 ) {
			name = name[ 0 .. index ] ~ name[ index + 2 .. $ ];
			name = replace( name ); // recusive - not sure about the 'name = ' part
		
		}
		return name;
	}

	// Iterate a directory in breadth
	foreach( string name; dirEntries(args[1], SpanMode.breadth) )
	{
		name = replace( name );
		writef( args[2], name ); if ( args[2][ $ - 1 ] == '\\' ) writeln();
	}
}
