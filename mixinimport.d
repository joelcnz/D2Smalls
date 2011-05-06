// Based on Peter Alexander - http://stackoverflow.com/questions/3555456/examples-of-what-ds-templates-can-be-used-for
// To compile enter: dmd mixinimport.d -J.
// Note: -J to use path to for import("script.txt")
import std.stdio;
import std.string;

string make_ints(string s)
{
    string ret = "";
    foreach (varname; split(s))
        ret ~= "int " ~ varname ~ "; ";
    return ret;
}

void main()
{
    mixin( make_ints( import( "script.txt" ) ) );
    foo = 1;
    bar = 2;
    xyz = 3;
	writeln(foo, " ", bar, " ", xyz);
}