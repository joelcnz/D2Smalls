---------- jdele.d ----------

// Simple sample: how to use delegates within objects

import std.stdio;

// DelegateClass: a class with declared delegate function "printText"
class DelegateClass
{
  public void delegate(char[] ) printText;
	public void delegate(char[],int ) printText2;
}

int main()
{
    // Function print
    void print(char[] text) { writefln(text); }
		void print2(char[] text,int number ) { writefln(text,number); }

    // Initialize a DelegateClass
    DelegateClass delclass = new DelegateClass();

    // Assign the delegate "printText" to function "print"
    delclass.printText = &print;
		delclass.printText2 = &print2;

    // Call printText to test

    delclass.printText(cast(char[])`Odd person: "HELLO Joel, how old are you today (July 2009)?"`);
    delclass.printText2(cast(char[])`Joel: "Age: %d"`,30);

    return 0;
}
---------- jmixinst.d ----------

import std.stdio;

void main()
{
    int j;
    mixin(`
	int x = 3;
	for (int i = 0; i < 3; i++)
	    writefln("%d, %d",x + i, ++j);
	`);    // ok

    const char[] s = "int y;";
    mixin(s);  // ok
    y = 4;     // ok, mixin declared y
		writefln("y=%d",y);

    //char[] t = "y = 3;";
    //mixin(t);  // error, t is not evaluatable at compile time

//    mixin("y =") 4; // error, string must be complete statement

    mixin("y =" ~ "4;");  // ok
}
---------- jswitch.d ----------

//Not sure if it is what I'm thinking
import std.stdio;

void main() {
	int age=5;
	switch ( age ) {
CaseRangeStatement:
	case FirstExp : .. case LastExp : Statement
			writefln("Your young!");
		break;
		default:
			writefln("Your old!");
		break;
	}
}
---------- jtype.d ----------

//#
//Needs wildcard (eg. 'jtype *.d')
/**
	Compile: dmd jtype.d wildcard.lib - but has warning about he library
*/
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
	version (none)
		if(wildMatch("*.d", "jtype.d"))
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
					string scan = fileName[lastIndexOf(fileName, `\`)+1..$];
					if ( wildMatch( wild, scan ) && scan[ 0 .. lastIndexOf( scan, '.' ) ] != "z" &&
						tolower( fileName[ lastIndexOf( fileName, '.' ) + 1 .. $ ]) != "exe" &&
						tolower( fileName[ lastIndexOf( fileName, '.' ) + 1 .. $ ]) != "obj") {
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
