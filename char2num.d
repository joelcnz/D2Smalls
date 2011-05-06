import std.stdio;

void main() {
	auto str="I went for a walk.";
	int total=0;
	foreach(c;str)
		total+=c;
		//total+=cast(int)c;
	writefln(`This is the text: "%s" and this is the number from it %d`,str,total);
}
