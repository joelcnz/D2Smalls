import std.stdio;

void main(string[] args) {
//	args~="WINDOWS96"; //WINDOWS96 outputs 666
	foreach( word; args[ 1 .. $ ] ) {
		size_t total = 0;
		foreach( s; word )
			total += (s & 0xFF);
		writefln( `str="%s", chars add up to: %d`, word, total );
	}
}
