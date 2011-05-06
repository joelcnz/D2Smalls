import std.stdio: writeln;
import std.conv: to;

const logging = true;

void log(string delegate() dg)
{
    if (logging)
		writeln("Log> ", dg());
}

void foo(int i)
{
    log({ return "Entering foo() with i set to " ~ to!string(i); });
}

void main() {
	foo(2);
}
