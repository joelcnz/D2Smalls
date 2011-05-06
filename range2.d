import std.stdio;

class A(T)
{
	T[] _names;

	this( string[] args )
	{
		_names = args;
	}
	
	bool empty() { return _names.length == 0; }
	void popFront() { _names = _names[ 1 .. $ ]; }
//	void popBack() { _names = _names[ 0 .. $ - 1 ]; }
	T front() { return _names[0]; }
//	T back() { return _names[ $ - 1 ]; }
}

void main( string[] args )
{
	auto a = new A!string(args);
	int i = 0;
	foreach (e; a)
	{
		writeln( i++, " - ", e );
	}
	foreach (e; a)
	{
		writeln( e );
	}
}
