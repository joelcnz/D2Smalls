import std.stdio;

// here just for 'typeof(return)'
uint retValue() {
	typeof(return) number = 1979;
	
	return number;
}

class Number(T) {
	private T _var;
	void opAddAssign(T var) {
		static if (is(T == string))
			_var ~= var;
		else
			_var += var;
	}
	void opCatAssign(T var0) {
		static if (is(T == string))
			_var ~= var0;
		else {
			switch (var0) {
				case 0: .. case 9:
					_var *= 10;
				break;
				case 10: .. case 99:
					_var *= 100;
				break;
				default:
				break;
			}
			_var += var0;
		}
	}
	Number opAssign(T var) {
		 _var = var;
		return this;
	}
	T opCall() {
		return _var;
	}
}

void main() {
	alias writeln p;
	p("print");
	
	auto number = new Number!int;
	auto num2 = new Number!int;
	number += 2;
	number += 5;
	writeln(number());
	number = num2 = 37;
	writeln(number(), " num2=", num2());
	writeln(number());
	number ~= 5;
	writeln(number());
	number~=7*7;
	writeln(number());
	
	auto strng = new Number!string;
	strng ~= "House";
	writeln(strng());
	strng ~= " cat";
	writeln(strng());
}
