import std.stdio;

/**
	This program is to <b>test</b> out docs<br>
*/
/// This is a <b>test</b> and it passes, <i>but why are these things under the function?</i>
int main(string[] args) {
	/// chop the first string off - this not work with docs
	int b,c;
	args=args[1..$];
	/** Loop through user input numbering them off. */ // this not work with docs either
	int d;
	foreach(i,a;args)
		writefln("%s. %s",i+1,a);
	return 0;
}
