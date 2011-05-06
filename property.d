// What does the statement '@property' do, ever? Some thing to do with the '()'s
import std.stdio;

class Number {
	private int _num;
	@property
	void num(int num0) { _num = num0; }
	@property
	int num() { return _num; }
}

void main() {
	auto number = new Number;
	number.num = 5;
	writeln(number.num);
	number.num = 7;
	writeln(number.num);
}
