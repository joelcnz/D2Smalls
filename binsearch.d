import std.stdio, std.array, std.random;

void main() {
	writeln("Being assertive");
	assert( binarySearch([1,3,5,7,9],5) );
	assert( ! binarySearch([1,3,5,7,9],6) );
	writeln("Maybe no assertive any more");
	const MAX=10; //20;
	foreach(i;0 .. MAX) {
		int[] nums;
		foreach(r;0..MAX)
			nums~=uniform(0,MAX);
		binarySearch(nums.sort,uniform(0,MAX));
	}
}

bool binarySearch(T)(T[] input,T value) {
	writeln("Looking for: ",value);
	while(!input.empty) {
		writeln("Current input: ",input);
		auto i = input.length/2;
		auto mid = input[i];
		if ( mid<value )
			input=input[i+1..$];
		else if ( mid>value )
			input=input[0..i];
		else {
			writeln("Found!");
			return true;
		}
	}
	writeln("Not found!");
	return false;
}
