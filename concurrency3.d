import std.stdio, std.concurrency;

//version = compileFail;

void fun(string str) {
     writeln(str);
}

version( compileFail )
	void fun2(char[] str) {
		 writeln(str);
	}

void fun3(int i) {
     writeln(i);
}

void main() {
	string str1 = "foo";  // string is an alias for immutable(char)[].
	version( compileFail )
		char[] str2 = "foo".dup;
    auto t1 = spawn(&fun, str1);  // Works.  Pointers to immutable data.
	version( compileFail )
		 auto t2 = spawn(&fun2, str2);  // Error:  Pointers to mutable data.
    auto t3 = spawn(&fun3, 1);  // Works.  No pointer indirection at all.

    send(t1, str1);  // Pass a message.  Works.  Pointers to immutable data.
	version( compileFail )
		 send(t1, str2);  // Error:  Pointers to mutable data.
    send(t1, 1);     // Works.  No pointer indirection at all.
}
