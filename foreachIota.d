// Org: stackoverflow
import std.stdio, std.typetuple;

template Iota(size_t a, size_t b) //All integers in the range [a, b)
{
    static if (a < b) { alias TypeTuple!(a, Iota!(a + 1, b)) Iota; }
    else { alias TypeTuple!() Iota; }
}

void main() {
	//Not possible with 'for'
	foreach( i; Iota!( 0, 10 ) ) {
		//int[i] arr;
		writeln( i );
	} 
}
