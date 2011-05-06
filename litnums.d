//#string lituals(sp) are converted to int's by defualt
import std.stdio;

enum ulong SIZE_IN_A = (1024 * 1024 * 1024 * 2); //#string lituals(sp) are converted to int's by defualt
const ulong SIZE_IN_B = (1024LU * 1024 * 1024 * 2);

void main() {
	writef("A:%d\nB:%d",SIZE_IN_A,SIZE_IN_B);
}

