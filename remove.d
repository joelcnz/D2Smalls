import std.stdio;

void main() {
	char[] s = "Hello IDEone@ D world!";
	void p() {
		writefln(s);
	}
	p;
	remove(char)(s,12);
	p;
}

void remove(T)(ref T[] a,int i) {
	if (is(type(a[0]) != char))
		delete a[i];
	if (i != a.length-1)
		a=a[0 .. i] ~ [i + 1 .. $];
	else
		a.length = a.length - 1;
}
