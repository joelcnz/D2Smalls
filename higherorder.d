///Jesse Philips
import std.stdio: writeln;
import std.algorithm : map, iota;
import std.conv : to;

void main() {
	int squareDel(int a) { return a*a; }
	int cubeDel(int a) { return a*a*a; }
	int funny(int a) { return (a+1+a*2)/a; }

	auto delarr = [&squareDel, &cubeDel, &funny];
	auto arr = iota(1, 10);

	foreach(del; delarr)
		writeln(map!(del)(arr));

}

