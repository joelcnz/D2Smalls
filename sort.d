// cant make out this program, of course.
import std.stdio,std.conv;
import std.algorithm;

void main() {
	int[] a = [4,8,5,2,0,5,4];
	
	static bool greater(int a, int b)
	{
	    return a > b;
	}
	sort!(greater)(a);  // predicate as alias
	sort!("a > b")(a);  // predicate as string
	                    // (no ambiguity with array name)
	void display() {
		foreach(i;a) {
			write(to!string(i)~" ");
		}
		writeln();
	}
	display;
	
	sort(a);            // no predicate, "a < b" is implicit

	display;

	writeln("Also:");
	a.length=0;
  a = [2, 5, 7, 9, 11];
  sort!("a > b")(a);
	display;
}