//This file is from 'The D programming language' book page 401 - 402
import std.concurrency, std.stdio, std.contracts;

void main() {
	auto low = 0, high = 100;
	auto tid = spawn(&writer);
	foreach (i; low .. high) {
		writeln("Main thread: ", i);
		tid.send(thisTid, i);
		enforce(receiveOnly!Tid() == tid);
	}
}

void writer() {
	for(;;) {
		auto msg = receiveOnly!(Tid, int)();
		writeln("Secondary thread: ", msg[1]);
		msg[0].send(thisTid);
	}
}
