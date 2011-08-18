//Org: from Philippe Sigauad 9 Aug 2011 8:50 ng d.D.learn (not counting the user input stuff
import std.stdio, std.typecons, std.conv;

string generateSwitches(T...)()
{
    string result = "switch(x) {\n";
    foreach(i,Type; T)
    {
        result ~= "case " ~ to!string(i) ~ ":\n"
                ~ "fun(tup[" ~ to!string(i) ~ "]);\n"
                ~ "break;\n";
    }
    return result ~ "default:\n"
                  ~ "assert(0, q{Bad index: } ~ to!string(x));\n}";
}

void actOnTuple(alias fun, T...)(int x, ref Tuple!T tup)
{
    mixin(generateSwitches!(T));
}

void foo(T)(ref T t) { writeln(t); t = T.init;}

void main()
{
	goto Awesome;
	
    auto tup = tuple(1, 3.14, "abc");
    auto x = 1;
    actOnTuple!foo(x, tup);
    writeln(tup);
    

















Awesome:
	class AwesomeNess {}
	
	auto Hamish = new AwesomeNess;
	auto awesome = Hamish;

	if ( Hamish is awesome )
		writeln( "Hamish is awesome!" );
	else
		writeln( "Hamish isn't awesome!" );

	return;

	writeln("Enter a character:");
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

version( all ) {
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
