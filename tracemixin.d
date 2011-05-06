import std.stdio, std.math;

// CTFE function that generates trace code.
string trace(string varName) {
	return `writeln("` ~ varName ~ `: ", ` ~ varName ~ `);`;
}

void main() {
    // Trace a function call.
    mixin(trace("sqrt(5f)"));

    // Trace a variable.
    int foo = 5;
	foo++;
    mixin(trace("foo"));
}
