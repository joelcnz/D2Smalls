// last edit 
import std.stdio; // for writefln
import std.c.string; // for strlen

//Just came into my head, then left, then came back, and it is, how do you use 'static if'
void main() {
	auto str=cast(string)"Hello, World!";
	auto chr=cast(char[])"Hello, World!";
	auto chc=cast(char*)"Hello, World!";
	auto aut="Hello, World"; // now which one does it use str, chr, chc or what?
	writefln("%s=%s, %s=%s, %s=%s  \n%s=%s(%s)",
		str.stringof,str, chr.stringof,chr, chc.stringof,chc[0..strlen(chc)],
		aut.stringof,aut,aut.mangleof );
	// none of these if statement work, always return false
	if ( is(aut:string) )
		writefln("is(aut:string)");
	if ( is(aut:char[]) )
		writefln("is(aut:char[])");
	if ( is(aut:char*) )
		writefln("is(aut:char*)");

	auto t=new Test(cast(string)"house");
	static if ( is(Test t==Test) )
		writefln("Yay, worked");
	else
		writefln("Work, it did not!");
}

//Hey! What's this class for?
class Test {
	string text;
	this(string text0) {
		text=text0;
	}
	void print() {
		writefln(text);
	}
}