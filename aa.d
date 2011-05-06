module small;
// Thought they said they've moved the aa to library
// What would they use instead of 'new' if they remove it?
import std.stdio;

void main() {
	string[string] test;
	test["House Key"]="house";
	test["Shed Key"]="shed";
	foreach(k,v;test)
		writeln(k," for ",v);
}
