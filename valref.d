/**
	This is from a news group.
*/
import std.stdio;

void main() {
   auto a = new int[1];
   auto b = a;
   a[0] = 5;
   assert(a == b);
   assert(a[0] == b[0]);
   assert(a is b);
   writefln("%x == %x", &a[0], &b[0]);
   moreExample(a, cast(uint) &a[0]);
}

void moreExample(int[] a, uint aAddr) {
   assert(cast(uint)&a[0] == aAddr);
   writefln("%x == %x", &a[0], aAddr);
}
