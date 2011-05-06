import std.stdio;

template mud(int a, int b)
{
	int subtraction()
	{
		return a - b;
	}
	int devide()
	{
		return a / b;
	}
}

void main()
{
	writeln( mud!( 10, 3 ).subtraction );
}