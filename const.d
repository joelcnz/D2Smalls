import std.stdio;

void main() {
	auto text = "this is a string of charaters.".dup; // dup for making it 'char[]' instead of 'string'
	writeln(text);
	text[0] = 'T';
	writeln(text);
	const constText=text;
	constText[0]='X'; // error
}

/+
output:
c:\jpro\dpro2\small\>dmd const.d
const.d(9): Error: constText[0] isn't mutable
c:\jpro\dpro2\small\>_
+/