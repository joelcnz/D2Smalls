import std.stdio;
import std.datetime;

void main()
{
    StopWatch sw;
	sw.start;
	bar;
	writeln( "Time: ", sw.peek().to!("msecs", real) ); //"seconds"
	
	foo;
}

void bar() {
	real[] arr;
	foreach( d; 0f .. 10_000_000 ) {
		arr ~= d;
	}
}
void foo() {
   StopWatch sw;
   static immutable N = 100;
   TickDuration[N] times;
   TickDuration last = TickDuration.from!"seconds"(0);
   foreach (i; 0..N) {
       sw.start(); // start/resume mesuring.
       foreach (Unused; 0..1000000) bar();
       sw.stop();  // stop/pause mesuring.
       // Return value of peek() after having stopped are the always same.
       writeln((i+1)*1000000, " times done, lap time: ",
               sw.peek(), "[ms]"); //#need editing
       times[i] = sw.peek() - last;
       last = sw.peek();
   }
   real sum = 0;
   // When you want to know the number of seconds of the fact,
   // you can use properties of TickDuration.
   // (seconds, mseconds, useconds, hnsecs)
   foreach (e; times) sum += e.hnsecs;
   writeln("Average time: ", sum/N, " hnsecs");
}
