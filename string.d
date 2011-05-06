//# cructs
module string;

private import std.stdio;

void main() {
	string a, b;
	a = "House"; // assign a value to a
	b = a; // /copy/ (assign) a to b //# cructs
	b ~= " cat"; // add to b
	write(a); // print a to see if it is still just what it was first assigned to and it is.
}
