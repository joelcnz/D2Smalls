import std.stdio;

template greet( string s )
{
	auto foo() { return s ~ " Alan"; }
}

void main()
{
	writeln( greet!"Hello".foo );
}