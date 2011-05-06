//#what's the story with this. trying to compile Chris Miller's ini.d file
import std.stdio;
import std.string;

//look at string module

void main() {
	//char* s = cast(char*)"testing";
	string s = "testing";
	//printf("'%s'", toStringz(s));
	// char* p;
	//writef("'%s'", toStringz(s)[0 .. s.length]); //#what's the story with this. trying to compile Chris Miller's ini.d file. What about
	s = cast(string)toStringz(s)[0 .. s.length];
}
