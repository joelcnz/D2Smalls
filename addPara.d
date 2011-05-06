//#and this activates
import std.algorithm, std.ctype, std.regex, std.range, std.stdio, std.string;

alias std.algorithm.find find;

void main() {
	PersonData[string] pd;
	addParagraph("Joel. I went for a walk and fell down a hole.",pd);
	if ("Joel" !in pd) {
		write("Not there!"); //#and this activates
		return;
	}
	write("Paragraph: Total word count ", pd["Joel"].totalWordsSpoken);
}

struct PersonData {
	uint totalWordsSpoken;
	uint[string] wordCount;
}

void	addParagraph(string line, ref PersonData[string] info) {
	line = strip(line);
	auto sentence=line.find(". ");
	if ( sentence.empty ) {
		return;
	}
}
