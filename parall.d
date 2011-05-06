// Org: http://davesdprogramming.wordpress.com/2011/04/07/7/
import
	std.math,
	std.parallelism; // not work

void main() {
     auto logs = new double[1_000_000];

     // A parallel foreach loop is just like a regular foreach loop,
     // except its body may be executed in parallel.
     foreach(i, ref num; taskPool.parallel(logs)) {
         num = log(i + 1.0);
     }
}
