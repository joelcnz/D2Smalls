import std.stdio;
import std.string;
import std.random; // uniform(0,10);
import std.conv; //i=parse!int

void main() {
	int[2] variables;
	string input;
	writeln("Enter 'quit' to exit");
	int rand() { return uniform(0, 100); }
	for (;;) {
		foreach (ref v; variables)
			v=rand;
		int answer, guess;
		answer=variables[0]+variables[1];
		do {
			write(variables[0], "+", variables[1], "=");
			input=strip(readln());
			if (input!="" && input[0]=='q')
				goto quit;
			if (isAValidNumber(input)==false) {
				writeln("Try, try, try again!");
				continue;
			}
			guess=parse!int(input); // User input
			if (guess==answer)
				writeln("You're right!");
			else
				writeln(guess<answer ? "higher" : "lower");
		} while (guess!=answer);
	} //for
quit:
	writeln("Ok then, see you later, do call again! :-)");
}

bool isAValidNumber(string testNumber) {
	if (testNumber.length==0)
		return false;
	foreach (chr; testNumber)
		if (chr<'0' || chr>'9')
			return false;
	return true;
}

class View
{
private:
	string _info;
public:
	
}
