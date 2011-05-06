//This file is from 'The D programming language' book page 406 - 407 -- but it doesn't WORK!
//#What's with enum? Wouldn't auto or const suffice?
import std.algorithm;
import std.concurrency: spawn, receiveOnly, stdin, send;
import std.stdio: write, writeln, File;

void main() {
	enum bufferSize = 1024 * 100; //#What's with enum? Wouldn't auto or const suffice?
	auto tid = spawn(&fileWriter);
	// Read loop
	foreach (ubyte[] buffer; stdin.byChunk(bufferSize)) {
		send(tid, buffer);
	}
}

void fileWriter() {
	auto f = File("emptyfile.txt", "w");
	// Write loop
	for (;;) {
		auto buffer = receiveOnly!(immutable(ubyte)[])();
		f.write(buffer); // You can see as you type
	}
}
