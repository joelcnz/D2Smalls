// readf Not work! - using readln
import std.stdio;
//import std.string: strip;

void main() {
	writeln( "Enter two numbers:" );
	int x, y;
	readf( "%d %d", &x , &y );
	writeln( x + y );
//	string input;
	//input = strip(readln); // this isn't readf!
	// pop end (new line character)
//	write(`"`~input~`"`);
//	for(int x; stdin.readf(" %d ",&x) == 1;) // not work, 2.048 - use nums.txt (readf.d < nums)
//		writeln("x=",x);
	/* 
	//not work
	int x,y,z;
	if (readf(" %d %d ",&x,&y)==1) {
		z=x+y;
		writeln(x," + ",y," = ",z);
	}
	*/
}
