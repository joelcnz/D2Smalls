import std.stdio: writefln;
import std.file: dirEntries, SpanMode, DirEntry;
import std.string: find, rfind;

void main(string[] args) {
	if (args.length < 3)
		return;
	// Iterate a directory and get detailed info about it
	foreach (DirEntry e; dirEntries(args[1], SpanMode.breadth)) {
		if (e.name.rfind(".") != -1 && e.name[ e.name.rfind(".") .. $] == args[2])
			writefln("bytes %d %-110s", e.name[e.name.find(`\`) + 1 .. $], e.size);
	}
}
