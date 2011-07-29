//# not get working, like delegates - 7 May 2010
import std.stdio, std.string, std.algorithm;

void main() {
	int[] arr = [ 5, 8, 4, 6, 23 ];
	//string[] arr = split( "aaa cc bb" );
	
	void display() { foreach( a; arr ) writeln( `"`, a, `"` ); writeln(); }
	display;
	//sort!( ( int a, int b ) { return arr[a] < arr[b]; } )(arr); // not work, does compile
	sort!"a < b"(arr);
	display;
	sort!"a > b"(arr);
	display;
}
