// http://stackoverflow.com/questions/125008/hidden-features-of-d
import std.stdio;
import std.conv;

int sum(ref int var, int first, int last, lazy int f)
{
    int result = 0;

    for (var = first; var <= last; var++)
    {
        result += f();
    }

    return result;
}


void main()
{
    int i;

    writeln(sum(i, 1, 2, i + i));
	writeln(i);
}

/*
output:
6
3
*/