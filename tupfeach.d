import std.stdio;
import std.typecons;
import std.typetuple;	// for TypeTuple

void main() {}

unittest {
    alias TypeTuple!(int, long, double,byte,char[]) TL;

	writeln(typeid(TL));
	
    foreach (T; TL) {
			writeln(T.stringof);
			if ( T.stringof=="int" ) {
				writeln("This is int");
			}
    }
	
	auto values = tuple(1, 2.0, "Hey!", cast(char[])"Hi");
	foreach(i, v; values.expand) {
		writeln(i, ` - "`, v, `" type=`, typeid(v));
		if (is(typeof(v)==double))
			writeln("'double' found!");
	}
	values.field[2]="2 - Hey you!";
	writeln(values.field[2]);
	
	fun("This is fun. Add: ", 5, "+", 2, "=", 7);

	auto value = tuple("Top", 10, 3.7);
	writeln('\n', value);
	value.field[0]="Bottom";
	foreach (i, v;value.expand)
		writefln("[%s]-'%s'", i, v);
}

void fun(T...)(T args) {
	gun(tuple(args));
	foreach (i, a; args)
		write(i, " - (", a, ")" );
}

void gun(T)(T value) {
	writeln(value.expand);
	foreach (i, v; value.expand)
		writefln("%s - '%s'", i, v);
}