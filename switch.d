import std.stdio;
import misc;

void main()
{
	writeln("Enter a charater:");
	char input = readln[0]; // 0 .. $ - 1 ];
	switch (input)
	{
		case 'a': .. case 'z':
		case 'A': .. case 'Z':
			writeln(input, " is a letter of the alphabet");
		break;
		default:
			writeln("Nop.");
		break;
	}
}
