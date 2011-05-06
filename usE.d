// Not work! dmd 1.040 - works dmd 2.029
// Off digitalmars.D.learn - unknowen/John C
import std.stdio;
import std.conv;
import std.string;

void main() {
	string str = "1 2 3 4 5 6";
	double[] numbers = std.conv.to!(double[])(split(str));
	writefln(std.conv.to!string(numbers));
	writeln(std.conv.to!string(numbers, "( ", ", ", " )"));
	
	writefln(to!string(to!(double[])(split("1.0 2.0 3.0 4.0 5.0 6.0 7.0")), "\nvoid main() {\n" // needs import std.conv
		"  double[] dbs= [", ", ", "];\n}\n"));
	
	foreach(s;split("I went for a walk and fell down a hole!")) {
		writefln(s);
	}
}
