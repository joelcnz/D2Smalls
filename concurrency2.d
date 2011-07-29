//Org from D book: Works now, (book version had wrong in three places)
import std.algorithm, std.concurrency, std.stdio;
 
void main() {
	//enum bufferSize = 1024 * 100;
	size_t bufferSize = 7;
	auto tid = spawn( &fileWriter );
	// Read loop
	foreach( buffer;
		stdin.byChunk( bufferSize ) ) {
		send( tid, buffer.idup );
	}
}

void fileWriter() {
	// Write loop
	for( ; ; ) {
		auto buffer = receiveOnly!( immutable(ubyte)[] )();
		stdout.write( buffer );
	}
}
