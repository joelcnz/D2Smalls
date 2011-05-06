import std.stdio;

struct Thing {
	string str = "unassigned";
	void opAssign( string str0 )
	{
		str = str0;
	}
	string opCall()
	{
		return str;
	}
}

void main() {
	Thing t;
	writeln( t() );
	t = "Assigned";
	writeln( t() );
}
