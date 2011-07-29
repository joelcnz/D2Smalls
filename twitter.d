//#not work, for dchar
//#notice the idup
//#Thing, the first character doesn't get removed
import std.stdio;
import std.string;
import std.file: write, read;
import std.process;
import std.ctype: toupper;
import std.conv;

//version = Testing;

/*
nevcnz d Got up late. Got a programmingThingSetupWithHelp,AlsoGotSomeThingWorkingThatIWantedForAWhile.I'mAboutToTrySomeDrivingInTheDriveway.
d nevcnz Does this text fit into one message? Does this text fit into one message? Does this text fit into one message? Does this text fit into one message?
*/
//const orgText = "i went for a walk and fell down a holeddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd";
//const orgText = "The police are trying to get a hold of Tim. They found his wallet. Can you help? He has to come in to get it, so they know it's the right person.";

/**
 * 1. Take a certin(sp) text file that's too big to fit in one twitter message.
 * 2. Count the spaces to see if can make it fit.
 * 3. Starting from the end of the message remove spaces and capitalize the words with the removed spaces.
 * 4. Open a new text file and fill it with the shortened message.
 */
void main(string[] args) {
	const openInTextFile = `c:\jpro\mp.exe twittersource.txt`;
	system( openInTextFile );
	
	// Get text to be worked on
	version (Testing) {
		auto orgText = args[1];
		if (orgText.length <= 139) {
			writeln( "Redundant" );
			return;
		}
		writeln("Before:\n", orgText);
		writeln("140: ", orgText[0 .. 139]);
	} else {
		auto orgText = cast(string)read("twittersource.txt");
	}
	writeln( "Potatoes" );
	
	// Count the spaces
	auto text = orgText.dup; // char[], not string
	auto i = cast(int)text.length - 1;
	auto numToRemove = cast(int)text.length - 140;
	int spaces = -2; // the two spaces at the start are not counted (eg. "D nevcnz ...")
	foreach (c; text) {
		if (c == ' ')
			++spaces;
	}
	
	// Is there enough spaces for it to work?
	writeln ("spaces: ", spaces, " numToRemove: ", numToRemove);
	if (numToRemove > spaces) {
		system ("echo Not enough spaces.");
		system ("pause");
		return;
	}
	
	// removed minnumin(sp) number of spaces and do capitalizing(sp)
	bool inword;
	//#Thing, the first character doesn't get removed
	while (numToRemove > 0) {
		auto endOfWord = (inword == true && i >= 0 && text[i] == ' ' && i + 1 < text.length);
		auto passedFrstLet = (i == -1);
		version (Testing)
			writeln ("endOfWord: ", endOfWord, " passedFrstLet: ", passedFrstLet, " inword: ", inword, " i: ", i);
		if (endOfWord || passedFrstLet) {
			
			text[i] = cast(char)toupper( text[ i ] );
			
			version( none ) {
				char c = text[i + 1];
				if (c >= 'a' && c <='z')
					text[i + 1] = cast(char)('A' + c - 'a');
			}
			
			version( none ) {
				string tou = text[ i + 1 .. i + 2 ].idup;
				tou = toupper( tou );
				text[ i + 1 .. i + 2 ] = tou[];
			}
			
			//text[i + 1 .. i + 2 ] = toupper( text[i + 1 .. i + 2 ].idup ); //#notice the idup
			
			inword = false;
			text = text[0 .. i] ~ text[i+1 .. $];
			--numToRemove;
		}
		if (i >= 0 && text[i] != ' ')
			inword = true;
		--i;
	}
	// to do: removed minimin of spaces starting from the other end of the text
	version (Testing) writeln("After:\n", text);
//	if (text.length == 139) {
		version (Testing)
			writeln ("Text is correct! :-)");
		write("twitterresualt.txt", cast(char[])text);
		system( "twitterresualt.txt" );
		system( "pause" );
//	}
}
