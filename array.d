import std.stdio;

void main() {
	int[] arr = [1,2,3,4,5];
	assert( arr == [1,2,3,4,5] );
	arr[ 1 .. $ - 1 ] = 3;
	assert( arr == [ 1, 3, 3, 3, 5 ] );
	
	auto arr2 = arr;
	assert( arr2.capacity == 7 );
	arr2.reserve( 12 );
	assert( arr2 == [ 1, 3, 3, 3, 5 ] );
	assert( arr2.capacity == 15 );
	foreach( n; 0 .. 3 )
		arr2 ~= 7;
	assert( arr2 == [ 1, 3, 3, 3, 5, 7, 7, 7 ] );
}

/*
void notWork() {
	int[] nums;
	nums[5] = 5; // not work, old tutoral I guess, I think it's better not working.
}
*/
