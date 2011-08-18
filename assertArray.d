// 5 Sep 2010 - The D programming language (2.0)
import std.stdio;
import std.string;
import std.array;

void main(string[] args) {
     if (args.length > 1)
         writeln(args[1]);
     else
         writeln("No extra arguments");
     int[] nums;
     nums=[1,2,3];
     //int[] nums = [1,3,2]; // this works too, like the above
     assert(nums == [1,2,3]); // compare each element (I guess length first)

	int[] arr = [1,2,3,4,5];
	writeln(arr);
	
	Test[] arr2;
	foreach( element; "I tackled a bucket of penguins".split )
		arr2 ~= new Test( element );
	
	void display() {
		foreach( element; arr2 )
			write( element, ' ' );
		writeln();
	}
	writeln();
	display;
	int findNum(donkey, U)( donkey[] haystack, U needle ) {
		auto index = 0;
		while( haystack.length && haystack.front.toString != needle ) {
			haystack.popFront;
			++index;
		}
		return index;
	}
	arr2.insertInPlace( findNum( arr2, "bucket" ), [ new Test( "big" ) ] );
	display;
	arr2.insertInPlace( findNum( arr2, "penguins" ), [ new Test( "silly" ), new Test( "brown" ) ] );
	display;
	arr2.insertInPlace( arr2.length, [ new Test( "what" ), new Test( "a" ), new Test( "mess!" ) ] ); // end
	display;
	arr2.insertInPlace( 0, [ new Test( "Hamish" ), new Test( "and" ) ] ); // start
	display;
}

class Test {
	this( string text ) {
		m_text = text;
	}
	
	override string toString() {
		return m_text;
	}
	
	private string m_text;
}

/*
void notWork() {
	int[] nums;
	nums[5] = 5; // not work, old tutoral I guess, I think it's better not working.
}
*/
