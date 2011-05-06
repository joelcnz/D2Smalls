//This file is from 'The D programming language' book page 400
import std.concurrency, std.stdio;

void main() {
	auto low = 0, high = 100;
	auto message = "Yeah, hi #";
	spawn(&fun, message, low, high);
	foreach (i; low .. high) {
		writeln("Main thread: ", message, i);
	}
}

void fun(string text, int low, int high) {
	foreach (i; low .. high) {
		writeln("Secondary thread thread: ", text, i);
	}
}
