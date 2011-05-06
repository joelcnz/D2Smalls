import std.stdio;
import std.string; // indexOf
import std.algorithm;
import std.ctype, std.range, std.regex;

alias std.algorithm.find find;

void main() {
	char[] text=cast(char[])"  Pol. Marry, I will teach you! Think of yourself a baby
    That you have ta'en these tenders..
  Oph. My lord, he hath importun'd tender me a fool.
    In hourable fashion.";
	char[] line=text[0..indexOf(text,"\n")];
	auto sentence=line.find(". ");
	if ( sentence.empty ) {
		writeln("sentence is empty!");
		return;
	}
	auto persona=line[0..$-sentence.length];
	sentence= tolower(strip(sentence[2..$]));
	writeln(sentence);
}
