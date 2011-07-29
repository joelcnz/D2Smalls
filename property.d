// What does the statement '@property' do, ever? Some thing to do with the '()'s
import std.stdio;

class Number {
	private int _num;
	@property
	ref int num() { return _num; }
}

void main() {
	auto number = new Number;
	number.num += 5;
	assert( number.num == 5 );
	number.num -= 2;
	assert( number.num == 3 );
	writeln( "All tests passed!" );
}
