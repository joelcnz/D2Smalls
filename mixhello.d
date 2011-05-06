//Org from 2:44 of http://video.google.com/videoplay?docid=1440222849043528221&hl=en
//Does not work with DMD 2.0 - fixed it! :-D
import std.stdio;

void main()
{
	mixin(greet("Hello"));
}

string greet(string greeting) {
	return `writefln("`~greeting~` World");`;
}

//void test(

//does it convert to 'writefln("Hello World");'?

/*
//Org from 2:44 of http://video.google.com/videoplay?docid=1440222849043528221&hl=en
import std.stdio;

void main() {
	mixin(greet("Hello"));
}

char[] greet(char[] greeting) {
	return `writefln(`~greeting~` World);`;
}
*/