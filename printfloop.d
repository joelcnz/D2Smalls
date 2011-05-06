//import std.c.stdio;
import std.stdio;

void main()
{
	printf( "Enter 42 to finish\n" );
	int[] nums;
	for ( int num = 0 ; num != 42; scanf( "%d", &num ) )
	{
		nums ~= num;
	}
	if ( nums.length > 1 )
		nums = nums[ 1 .. $ ]; // Note doesn't include the escape number (42)
	else
	{
		printf( "Insuffenient(sp) information." );
		return;
	}
	
	printf( "Numbers entered:\n" );
	foreach ( n; nums )
	{
		printf( "%d\n", n);
	}
}
