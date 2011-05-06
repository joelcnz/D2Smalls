import std.stdio;
import std.algorithm: reduce;

void main() {
	writeln (reduce!"a*b"([1, 2, 3])); // fine, translates to 1 * 2 * 3
}
