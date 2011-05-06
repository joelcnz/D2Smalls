// this module will fail a unittest there's another module compiled that has a 'main' function in it
import std.stdio;

/// TDD - test driven development tool
string test(in string exp, in string should)
{
	// Note no new lines
	return
		"
		write(`" ~ should ~ " - Testing ( " ~ exp ~ " ) - `);
		if ( " ~ exp ~ " )
		{
			write(`PASS`);
		}
		else
		{
			write(`FAIL`);
		}
		writeln(` - line: `,__LINE__, ` file: `, __FILE__);
		";
}

unittest
{
	mixin(test("1 == 1", "One qual one"));
	mixin(test("1 == 0", "One qual zero?"));
	string s;
	mixin(test("s is null", "string s is null"));
}
