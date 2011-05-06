/**
	Origin: The D programming language (page 8)
	Date: 5 Sep 2010
	Method: script < journal.txt > z.txt
*/
import std.stdio;
import std.string;

void main() {
	uint[string] dictionary;
	foreach (line; stdin.byLine()) {
		// Break sentence into words
		// Add each word in the sentence to the vocabulary
		foreach (word; splitter(strip(line))) {
			if (word in dictionary)
				continue;
			auto newID = dictionary.length;
			dictionary[word] = newID;
			writeln(newID, '\t', word);
		}
	}
}
