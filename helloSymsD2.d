module hello;

import std.stdio, std.string;

void main() {
	// Say hello
	writeln("Hello D2 World!");

	auto symbols = ["
101
010
101",
"
010
111
010",
"
00111000
01000100
10111010
01010100 
01010100
00101000
00101000
00010000",
"
11111111
11111110
11010100
11101010
11010100
11101010
11010100
10000000"];
	multiSymbol(symbols, &Symbol, (){ writeln(); });
	multiSymbol(symbols, &zerosAndOnes, (){ writeln("\n<>"); });
}

void Symbol(string map) {
	// Get rid of the first new line
	map = stripl!(string)(map);

	// replace the 0's and 1's
	foreach (i, bin; split!(string)("0 1"))
		map = replace(map, bin, split!(string, string)(" |#", "|")[i]);

	// Split data into lines and display each of them
	foreach (l; splitlines!(string)(map))
		writeln(l);
}

void zerosAndOnes(string map) {
	map = stripl!(string)(map);

	foreach (i, bin; split!(string)("0 1"))
		map = replace(map, bin, split!(string, string)("Z|O", "|")[i]);
	write(map);
}

void multiSymbol(string[] maps, void function(string) doMap, void delegate() bar) {
	foreach (map; maps) {
		doMap(map);
		bar();
	}
}
