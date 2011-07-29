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
	
	fromDoc;
}

void fromDoc() {
	int[] array = [ 1, 2, 3, 4 ];
	// sort in descending order
	sort!("a > b")(array);
	assert(array == [ 4, 3, 2, 1 ]);
	// sort in ascending order
	sort(array);
	assert(array == [ 1, 2, 3, 4 ]);
	// sort with a delegate
	bool myComp(int x, int y) { return x > y; }
	sort!(myComp)(array);

	assert(array == [ 4, 3, 2, 1 ]);
	
	sort!( (int x, int y) { return x < y; } )( array );

	assert(array == [ 1, 2, 3, 4 ]);
	
	// Showcase stable sorting
	string[] words = [ "aBc", "a", "abc", "b", "ABC", "c" ];
	sort!("toupper(a) < toupper(b)", SwapStrategy.stable)(words);
	assert(words == [ "a", "aBc", "abc", "ABC", "b", "c" ]);
}
