import std.stdio;
import std.string: split, newline;

version=New;

void main()
{
	string strArr = "I went for a walk and fell down a hole";
	int[] intArr = [1, 3, 2];
	string[] wordArr = split("I went for a walk and fell down a hole");
	real[] realArr = [1.05, 67.4, 43.96];
	alias printArray p;
	p(strArr, "");
	p(intArr);
	p(wordArr, newline);
	p(realArr, ", ");
}

void printArray(T)(in T[] arr, in string by = " ")
{
	version (New)
	{
		foreach (i; 0 .. arr.length)
		{
			write( *(arr.ptr + i), i < arr.length - 1 ? by : "");
		}
	}
	else
	{
		foreach (i, e; arr)
		{
			write( e, i < arr.length - 1 ? by : "");
		}
	}
	writeln();
}
