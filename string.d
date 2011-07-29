//# cructs
module string;

private import std.stdio, std.file;

void main() {
	string a, b;
	a = "House"; // assign a value to a
	b = a; // /copy/ (assign) a to b //# cructs
	b ~= " cat"; // add to b
	writeln( a ); // print a to see if it is still just what it was first assigned to and it is.

   auto bytes = cast(ubyte[]) read("file.txt", 5);
   if (bytes.length == 5)
       writefln("The fifth byte of the file is 0x%x", bytes[4]);
}
