//Not work!
module stdxml;

import std.stdio;
import std.xml;
import std.perf;

void benchmark (int iterations, invariant char[] content) {
	auto elapsed = new HighPerformanceCounter();
	elapsed.start;
	
	for (auto i=0; ++i < iterations;) {
	check(content);
	}
	
	elapsed.stop;
	float timer = elapsed.milliseconds / 1000.0;
	auto total = (content.length * iterations) / (timer * (1024 * 1024));
	writef(total);
	writefln(" MB/s");
}

void main()
{
	invariant char[] content = import ("hamlet.xml");
	for (int i = 11; --i;)
		benchmark (10, content);
}
