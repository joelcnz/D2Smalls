import std.stdio;
import std.c.windows.windows;
import std.utf;

string ansi(string str)
{
	wchar[] src = toUTF16(str).dup;
	char[] dest;
	dest.length = str.length;
	WideCharToMultiByte(0, 0, src.ptr, -1, dest.ptr, dest.length, null,
null);
	return cast(string)dest;
}

void main() {
	writeln(ansi(""));
}
