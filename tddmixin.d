import std.stdio;

debug = TDD;

void main()
{
	mixin(test("1 == 1", "One qual one"));
	mixin(test("1 == 0", "One qual zero?")); // Not sure on this
	string a;
	mixin(test("a is null", "string a is null"));
}

/*
// not work
mixin template TDD(string test, string shouldbe) {
	write(shouldbe, " - Testing ( ", test, " ) - ");
	if ( mixin( test ) ) {
		write("Hay");
	}
}
*/

/// TDD - test driven development tool
string test(in string exp, in string should)
{
	// Note no new lines
	debug (TDD)
		return
			"write(`" ~ should ~ " - Testing ( " ~ exp ~ " ) - `);"
			"if ( " ~ exp ~ " )"
			"{"
			"	write(`PASS`);"
			"}"
			"else"
			"{"
			"	write(`FAIL`);"
			"}"
			"writeln(` - line: `,__LINE__, ` file: `, __FILE__);";
	return "";
}
