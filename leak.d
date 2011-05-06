module leak;

version=first;
//version=second; // fail on capacity

version (second) {
	////////////// D example
	/////////////////////////
	import std.stdio;
	
	void main()
	{
	    double[] x;
	
	    foreach(uint i;0..100) {
	        x.length = 0;
	
	        writefln("Array capacity (1) = %u",x.capacity);
	        assumeSafeAppend(x);
	        writefln("Array capacity (2) = %u",x.capacity);
	
	        foreach(uint j;0..5000000)
	            x ~= j;
	
	        writefln("At iteration %u, x has %u elements.",i,x.length);
	    }
	}
}

version (first) {
	import std.stdio: writefln;
	
	void main() {
	    auto x = new real[5_000_000];
	
	    foreach (i; 0 .. 1_000) {
	        int x_len = 0;
	
	        foreach (j; 0 .. 5_000_000) {
	            x[x_len] = j;
	            x_len++;
	        }
	
	        writefln("At iteration %u, x has %u elements.", i, x_len);
	    }
	}
}