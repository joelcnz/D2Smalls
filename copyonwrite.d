import std.stdio;

void main() {
	writeln(); // for rdmd (eg enter 'copyonwrite.d' in the terminal)

	string a = "RAT";
	string b;

	void pnt() {
		writeln( 'a', ':', ' ', a, ' ', 'b', ':', ' ', b );
	}

	pnt;

	b = a;
	a = "MEAT";

	pnt;
}
