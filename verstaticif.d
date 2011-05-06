//
// rdmd -version=bar verstaticif.d
//
/**
	Aurthor: from D.learn news group
	Date: 4:54 28 Feb 2011
*/
module verstaticif;

import std.stdio;

version ( foo ) {
enum version_foo = true;
} else {
enum version_foo = false;
}

version ( bar ) {
enum version_bar = true;
} else {
enum version_bar = false;
}

void main() {
	static if ( version_foo || version_bar ) {
		writeln("version_foo || version_bar");
	} else {
		writeln("neither version_foo || version_bar");
	} 
}