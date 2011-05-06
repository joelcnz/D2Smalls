/**
	Trying out regex
	Date: September 10 2010
*/
module regex;

import std.stdio;
import std.regex;

/**
	Struct to test for vaild e-mail address
*/
struct EMail {
	string testEmail0; /// string to test
	/// Show the string to test
	void question() {
		writeln("Email? ", testEmail0);
	}
	/// Produce answer whether is is a valid style for an e-mail address (could be that no one has the address yet)
	void answer() {
		auto result = match(testEmail0, regex(email));
		if (result.empty)
			writeln(`No, it isn't :-|`);
		else
			writeln("Yes, it is. :-D");
	}
	/// Call methods question and answer
	void action() {
		question, answer;
	}
}

/// Testing regex
void main() {
	writeln("e-mail: ", email);
	writeln("url: ", url);
	foreach(m; match("JoelJoshJonothan", regex("Jo"))) {
        writefln("%s[%s]%s", m.pre, m.hit, m.post);
    }
	writeln();
	// Note: Inner struct did not compile
	foreach (a; [EMail("joelcnz@gmail.com"), EMail("sadg%4af.com")])
		a.action;
}

