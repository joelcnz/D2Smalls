import std.stdio;

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

version( none ) {
	//not work - as follows
   string foo = "foo";
   string bar = "bar";
   string mrX;
   switch (mrX)
   {
      case foo:
         writeln(foo);
         break;
      case bar:
         writeln(bar);
         break;
      default:
         writeln("who knows");
   }
}
}
