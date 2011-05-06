//This file is from 'The D programming language' book page 399
import std.concurrency, std.stdio;

void main() {
	auto low = 8, high = 100;
	auto tid=spawn(&fun, low, high);
	foreach (i; low .. high) {
		writeln("Main thread: ", i);
	}
}

void fun(int low, int high) {
	foreach (i; low .. high) {
		writeln("Secondary thread: ", i);
	}
}
