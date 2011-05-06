import std.stdio;

void main() {
	typedef int int32;
	int32 cowCount;
	int cn = cowCount; // don't know the use of typedef, why can this happen? May as well use alias
	
	alias short int16;
	int16 bullCount;
}
