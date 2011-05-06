// Org from ng.learn 1 Mar 5:07am - Dr.Smith
import std.stdio;
import std.conv;

void main() {
	double[string] data;
	double[200][1_000] data2;

	for(int i = 0; i < 1_000; i++) {
		for(int j = 0; j < 200; j++) {

		  // fake multi-dim works
		  string str = to!string(i) ~ "," ~ to!string(j);
		  data[str] = i * j;

		  // real multi-dim does not work
		  data2[i][j] = i * j;
		}
	}
	
	writeln("30,70 = ", data[ "30,70" ] );
}