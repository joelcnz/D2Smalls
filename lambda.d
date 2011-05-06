//# not get working, like delegates - 7 May 2010
import std.stdio, std.string;

void main() {
	//int[] arr = [ 5, 8, 4, 6, 23 ];
	string[] arr = split( "aaa cc bb" );
	
	void display() { foreach( a; arr ) writeln( `"`, a, `"` ); }
	display;
//	sort!( ( a, b ) { return arr[a] < arr[b]; } )(arr);
//	display;
}
