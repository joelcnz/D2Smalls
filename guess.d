import std.stdio: write, writefln, readln;
import std.random: uniform;
import std.string: strip;
import std.conv: to;
import std.math: abs;

void main() {
	int answer, user, guesses=0, closeness;
	answer=uniform(0, 100+1);
	do {
		write("Guess the number (0 and 100): ");
		user=to!int(strip(readln));
		guesses++;
		if (user != answer) {
			write("That is an incorrect number: ");
			closeness = abs(user - answer);
			string howClose = closeness<6 ? "very close" : closeness<11 ? "close" : closeness<21 ? "far" : "very far";
			if (user > answer)
				writefln("%s - Lower", howClose);
			else
				if (user < answer)
					writefln("%s - Higher", howClose);
		}
	} while (user != answer);
	writefln("Hurray! you got it in just %s guesses!", guesses);
	write("Press enter to contiune..");
	readln;
}
