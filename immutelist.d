/**
	Taken out of 'The D Programming Language' book in page 294 on Friday 30 July 2010
*/
// Don't know the value of this program
//How do I get at the data? I don't think your supposed to
//#what package do I import
import std.stdio: writeln;
import std.contracts: enforce;

//version=Orginal;
version=Fail; // infinite loop and only the first node

class List {
	private int payload;
	private static List head;
	private List next;
	version (Orginal) {
		this(int[] data) immutable {
			enforce(data.length); //#what package do I import
			payload = data[0];
			if (data.length==1) return;
			next = new immutable(List)(data[1 .. $]);
		}
	}
	version (Fail) {
		this(int[] data) {
			enforce(data.length); //#what package do I import: Answer: std.contracts
			payload = data[0];
			if (data.length==1) return;
			next = new List(data[1 .. $]);
			if (! head)
				head=this;
		}
		void output() {
			List n=head;
			while (n !is null) {
				writeln(payload);
				n=next;
			}
		}
	}
}

void main() {
	auto lst=new List([1, 2, 4, 8]);
	version (Fail) lst.output;
}
