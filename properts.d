import std.stdio;

void main() {
	auto t=new Test(36);
	void w(immutable(char)[] suff) { writefln("%s=%d %s",t.count.stringof,t.count,suff);  } // and this also works
	w("before");
	t.count=t.count+1;
	w("after");

	w2(t,cast(char[])"before");
	t.count=t.count+1;
	w2(t,cast(char[])"after");

	foreach(i;[1,2,4,8,16,32,64]) {
		writefln("i=%d",i);
	}
}

void w2(Test t,char[] suff) {
	writefln("%s=%d %s",t.count.stringof,t.count,cast(char[])suff);
}

class Test {
	private:
	int _count;
	public:
	int count(int count0) { return _count=count0; }
	int count() { return _count; }
	this(int count0) {
		count=count0;
	}
}