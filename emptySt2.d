//#Why does this work?
import std.stdio;

void main() {
	auto empty = cast(char[])"";
	assert (empty !is null); // not !=, not work! :-) //#Why does this work?
	auto my_entry=new Entry;
	my_entry.setText(empty);
	;
}

class Entry {
	char[] text;
	void setText(char[] text ) {
		this.text=text;
		writefln("%s is set",text.stringof);
	}
}
