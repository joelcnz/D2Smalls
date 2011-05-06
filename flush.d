import std.stdio;

void main() {
	for( ; ; ) {
		write( "#" );
		version( Flush )
			stdout.flush;
	}
}
