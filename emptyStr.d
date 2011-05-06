import std.stdio;

void main() {
	string empty=""; // else: auto empty = cast(string)"";
	assert (empty !is null);
	auto my_entry=new Entry;
	my_entry.setText(empty);}

class Entry {
	string text;
	void setText(string text ) {
		this.text=text;
		writefln("%s is set",text.stringof);
	}
}
