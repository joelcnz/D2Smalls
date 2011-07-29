import std.stdio;
import std.string;

void main() {
	immutable hello = "Hello";
	writeln( toStringz( hello )[ 0 .. 5 ] );
}
