//Org from ng d.learn - Peter 1 March 7:58pm
/**
	Mixin CTFE
*/
module mixinctfe;

version = Works;

import std.stdio;
import std.conv;

string makePossibleAValues(string name, byte m) {
	string result = "immutable byte[] "~name~" = [";
	foreach (i; 0 .. m) {
		if (coprime(i, m)) {
			version( Works ) {
				result ~= to!string(i);
				if ( i + 1 != m ) // insert commas between all the numbers
					result ~= ", ";
			}
			else
				result ~= to!string(i) ~ ", "; // fails (Error: to(i) ~ ", " cannot be interpreted at compile time)
		}
	}
	return result ~ "];";
}

bool coprime(ulong a, ulong b) {
	return gcd(a, b) == 1;
}

ulong gcd(ulong a, ulong b) {
	while (b) {
		auto t = b;
		b = a % b;
		a = t;
	}
	return a;
}

void main() {
	mixin(makePossibleAValues("aValues", 26));
	writeln( makePossibleAValues("aValues", 26) );
}
