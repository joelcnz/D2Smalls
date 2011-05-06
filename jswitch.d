//Not sure if it is what I'm thinking
import std.stdio;

void main() {
	int age=5;
	switch ( age ) {
CaseRangeStatement:
	case FirstExp : .. case LastExp : Statement
			writefln("Your young!");
		break;
		default:
			writefln("Your old!");
		break;
	}
}