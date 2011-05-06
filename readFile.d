import std.stdio;
import std.file;

void main() {
	auto content = readText("readFile.d");
	write(content);
}
