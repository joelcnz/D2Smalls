module dwebsite;

import std.stdio;
import std.string;
void main(string[] args) {
	auto banner = "Hello world, oh look, a goat!";
	banner ~= " ";
	auto c = 0, s = 0, w = 5, l = 0;
	if ( args.length > 1 ) {
		banner = "";
		foreach (arg; args[ 1 .. $ ] )
			banner ~= arg ~ " ";
	}
	banner ~= banner[0 .. w - 1];
	l = banner.length;
  while ( true ) {
    foreach (a; 0 .. 1_000) {
		write(banner[s .. s + w] ~ "\r");
		stdout.flush;
	}
    if ( s + w + 1 > l )
		s = 0;
	else
		++s;
    ++c;
  }
}
