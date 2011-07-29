//#not working
import
	std.stdio,
	std.string;

//import jeca.misc;

//pragma( lib, "libjeca" );

void main() {
	int i = 3;
	char c = 'c';
	string s = "string";
	
	int J = 31;
	mixin( trace( "J" ) );
	mixin( trace( "J + 1" ) );
	
//	mixin( trace( "My age - ", "J + 1" ) );
	
	int x = 3, y = 4;
	mixin( trace( "x", "y" ) );
}

/+
string trace( in string title, in string varName ) {
	return `writeln("` ~ title ~ varName ~ `: ", ` ~ varName ~ `);`;
}
+/

//#import jeca.misc; // has trace in it
string trace( string str ) {
	return `writeln( "` ~ str ~ `: ", ` ~ str ~ `);`;
}

string trace( string x, string y ) {
	return `writefln( "` ~ x ~ `, ` ~ y ~ `: %s, %s", ` ~ x ~ `, ` ~ y ~ ` );`;
}

/+
string traceForList( in string title, in string varName ) {
	return `writeln( ` ~ title ~ `, ": ", ` ~ varName.stringof ~ `);`;
}

void traceList( in string varsName ) {
	foreach( var; varsName.split )
		//mixin( trace( var.stringof, "var" ) );
		mixin( traceForList( "var", "var" ) );
}
+/
