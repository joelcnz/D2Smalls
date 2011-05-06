/**
	Date: 5 Sep '10
*/
import std.stdio;
import std.variant;

void main() {
	Variant a;
	a=3.14;
	assert(a == 3.14);
	writeln(a*2);
	a="House";
	writeln(a);
	a~=" cat";
	assert(a == "House cat");
	writeln(a);
	
	Variant[] arr;
	arr.length+=1; // 'arr.length++;' not work, 'Error: arr.length is not an lvalue'
	arr[$-1]=3.14;
	arr.length+=1;
	arr[$-1]="House cat";
	foreach (d; arr)
		writeln(d);
	
	/+ // fails at the moment
	Variant b = new int[10];
	b[5] = 42;
	b[5] += 8;
	assert(b[5] == 50); // fails D2.048, & D2.049
	+/

	Variant[] b;
	b.length = 3;
	b[2] = 42;
	b[2] += 8;
	assert(b[2] == 50);
	writeln("42 + 8 = ", b[2]);
}
