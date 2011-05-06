pragma( lib, "ini.lib" );

import std.stdio, std.conv;

import ini.ini;

void main() {
	auto ini = new Ini( "initest.ini" );
	
	string section;

	foreach( houseIndex; 1 .. 2 + 1 ) {
		section = "house" ~ to!string( houseIndex );
		writeln( "'", section, "'" );
		if ( ini[ section ] is null )
			writeln( "fail" );
		writefln(
			"%s) house name is: '%s'",
			houseIndex,
			ini[ section ][ "name" ]
		);
		writefln(
			"Size is: '%s'",
			ini[ section ][ "size" ]
		);
	}
}

unittest
{
	string inifile = "unittest.ini";
	Ini ini;

	ini = new Ini(inifile);
	with(ini.addSection("foo"))
	{
		value("asdf", "jkl");
		value("bar", "wee!");
		value("hi", "hello");
	}
	ini.addSection("BAR");
	with(ini.addSection("fOO"))
	{
		value("yes", "no");
	}
	with(ini.addSection("Hello"))
	{
		value("world", "true");
	}
	with(ini.addSection("test"))
	{
		value("1", "2");
		value("3", "4");
	}
	ini["test"]["value"] = "true";
	assert(ini["Foo"]["yes"] == "no");
	ini.save();
	delete ini;

	ini = new Ini(inifile);
	assert(ini["FOO"]["Bar"] == "wee!");
	assert(ini["Foo"]["yes"] == "no");
	assert(ini["hello"]["world"] == "true");
	assert(ini["FOO"]["Bar"] == "wee!");
	assert(ini["55"] is null);
	assert(ini["hello"]["Yes"] is null);
	
	ini.open(inifile);
	ini["bar"].remove("notta");
	ini["foo"].remove("bar");
	ini.remove("bar");
	assert(ini["bar"] is null);
	assert(ini["foo"] !is null);
	assert(ini["foo"]["bar"] is null);
	ini.remove("foo");
	assert(ini["foo"] is null);
	ini.save();
	delete ini;
	
	writeln( "passed all tests" );
}
