import std.stdio;
import std.conv;

const logging=true;

void log(lazy string dg)
{
    if (logging)
		writefln("Log> %s", dg());
}

void foo(int i)
{
    log("Entering foo() with i set to " ~ to!string(i));
}

void main() {
	foo(3);
}
