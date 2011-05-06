/**
	file: unitt.d
	Date: 17.07.'10
	Unit test program, (look no main)
	dmdr --main unit.d (not work, asks about 16 bit)
*/
module unitt;

import std.stdio;

void main() {}

unittest {
	int[] nums = [];
	assert(find(nums, 5)==[]);
	nums=[1, 2, 3, 4];
	assert(find(nums, 3) == [3, 4]);
	assert(find(nums, 50)!=[3, 4]);
}

int[] find(int[] haystack, int needle) {
	writeln("##Find ", needle, " in ", haystack, "##");
	while (haystack.length>0 && haystack[0]!=needle) {
		haystack=haystack[1..$];
		writeln(haystack);
	}
	switch (haystack.length) {
		case 1: .. case 100:
			writeln("Found!");
		break;
		case 0:
			writeln("Not found..");
		break;
		default:
			writeln("Programming error!");
		break;
	}
	writeln("");
	
	return haystack;
}
