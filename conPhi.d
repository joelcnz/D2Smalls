// Philippe Sigaud from digitalmars.D.learn - Grokking concurrency, message passing and Co - July 11, 2010
import std.concurrency, std.stdio, std.perf;

void main() {
	immutable low = 0;
    immutable high = 1_000_000_000;

    auto c = new PerformanceCounter();

    foreach(NN; 0..10) { // 1 to 512 threads
        immutable N = 2^^NN;
        int C = 0;
        immutable step = (high-low)/N;
        writeln("# of threads: ", N);

        c.start;
        foreach(n; 0..N)
        {
            auto tid = spawn(&foo, low+n*step, low+(n+1)*step);
            tid.send(thisTid);
        }

        ulong sum;
        while(C < N) {
            auto end = receiveOnly!(bool, ulong)();
            if (end._0 == true) {
                C++;
                sum += end._1;
            }
        }
        c.stop;
        writefln("%s ms. Sum = %s", c.milliseconds,sum);
    }

    writeln("No thread: ");
    c.start;
    ulong count;
    foreach(i; low..high) count += i;
    c.stop;
    writefln("%s ms. Sum = %s", c.milliseconds,count);

//    writeln(Minus!((S!Z), S!(S!Z)).stringof);
//    writeln(Times!(S!(S!Z), S!(S!Z)).stringof);

}

void foo(int low, int high)
{
    ulong sum;
    auto msg = receiveOnly!(Tid)();
    foreach(i; low..high) sum += i;
    msg.send(true,sum);
}
