import std.stdio;
import std.string;

void main() {}

unittest {
	string str="three + four = ";
	writeln(append(str, 7));
	writeln(str.append(7));
	writeln("3 * 10 + 7 = ".append(37));
}

string append(string root, int x) {
	return format("%s%s",root, x);
}
