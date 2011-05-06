//#9 .. 0 does not work! 24.05.'10
import std.stdio;

void main() {
	foreach (reverse; 0 .. 9) //#9 .. 0 does not work! - Use library function
		writef("%s, ",reverse);
}
