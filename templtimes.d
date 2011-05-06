import std.stdio;

auto times( T1, T2 )( T1 x, T2 y )
{
	return x * y;
}

void main()
{
	writeln( "3 * 1.5 = ", times( 3, 1.5 ) );
	Number num1, num2;
	num1 = 1;
	num2 = 7;
	num1 = num2;
	writeln( num1.payload ); 
}

struct Number
{
	int _number;
	int payload() { return _number; }
	void opCall( int number )
	{
		_number = number;
	}
	void opAssign( int number )
	{
		_number = number;
	}
	void opAssign( Number number )
	{
		_number = number.payload;
	}
}
