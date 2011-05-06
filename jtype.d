//#
//Needs wildcard (eg. 'jtype *.d')
//ToDo: Put in SpanMode.shallow and throw a lot of code out
/**
	//Compile: dmd jtype.d wildcard.lib - but has warning about he library
	Compile: dmd jtype
	*  - but has warning about he library
*/

pragma( lib, "wildcard.lib" );

version=WildCard;
version=DontCountSubFolders;
//version=ListDir; // Does subfolders as well, so not what I want.
//debug = wildFile;

import std.stdio;
import std.file;
import std.string;

version (WildCard)
	import wildcard.wildcard;


void main(string[] args) {
	if (args.length == 1) {
		write("Usage: jtype [file1] [file2] ... [filen]");
		return;
	}
	//version (none)
		if ( "*.d".wildMatch( "jtype.d" ) )
			writeln("They match!");
		else
			writeln("They do NOT match :(");
	char[10] line; line[] = '-';
	const printFile = `writefln("%s %s %s\r\n", line ,fileName[2 .. $], line);`;
	version (WildCard) {
		version (DontCountSubFolders) {
			string[] files=getFiles(".");
			foreach (wild; args[ 1 .. $ ])
				foreach (string fileName; files) {
					writefln( "1st scan = \"%s\"", fileName );
					if ( lastIndexOf( fileName, '.' ) == 0 )
						continue;
					string scan = fileName[lastIndexOf(fileName, `\`)+1..$];
					
					bool hasExts( string[] exts ) {
						bool hasExt( string ext ) {
							return tolower( fileName[ lastIndexOf( fileName, '.' ) + 1 .. $ ] ) == ext;
						}
						foreach( ext; exts ) {
							if ( hasExt( ext ) == true )
								return true;
						}
						
						return false;
					}

					writefln( "2nd scan = \"%s\"", scan );
					if ( scan[ 0 .. lastIndexOf( scan, '.' ) ] != "z" &&
						! hasExts( [ "exe", "obj" ] ) &&
						wildMatch( wild, scan )	) {
						debug (wildFile)
							writefln("wild='%s', file='%s'", wild, scan);
						mixin(printFile);
						foreach (line2; splitlines(cast(string)read(fileName)))
							writeln(stripr(line2));
					}
				}
		} else {
			foreach (wild; args[1..$])
				foreach (string file; dirEntries(".", SpanMode.depth)) { //SpanMode.breadth)) {
					string scan = file[lastIndexOf(file, `\`)+1..$];
					if (wildMatch(wild, scan)) // eg wildMatch("*.d", "aa.d")
						mixin(printFile); //#
				}
		}
	}
	version (ListDir) {
		foreach (file; std.file.listdir(".", args[1]))
			mixin(printFile); //#
	}
}

string[] getFiles(string dir) {
	string[] files;
	bool callback(DirEntry* de)	{
	  if (! de.isdir)
		files~=de.name;
	  return true;
	}
	listdir(dir, &callback);

	return files;
}
